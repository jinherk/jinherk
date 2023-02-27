import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMessage extends StatefulWidget {
  NewMessage({
    required this.body,
    required this.time,
    required this.sender,
    required this.scrollController,
    required this.scrollToTop,
    required this.author_token,
    required this.mytoken,
    Key? key}) : super(key: key);
  final String body;
  final String time;
  final String sender;
  final String author_token;
  final String mytoken;
  final ScrollController scrollController;
  VoidCallback scrollToTop;


  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String imageUrl = "nothing";
  String likey = DateTime.now()
      .toString();
  int rnd = 10000;
  String mytoken = "";
  Map<String, dynamic>? messageData;


  @override
  void initState() {
    _loadrnd();
    messageData = {
      'title': 'EVERYNUE',
      'body': '채팅이 왔어요!',
      "type": "chat"
    };
    super.initState();
  }

  getToken() async {
    //토큰 받아오기
    await FirebaseMessaging.instance.getToken().then(
          (token) {
        setState(() {
          mytoken = token!;
        });
      },
    );
  }

  Future<void> resetSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${likey}');
  }

  _loadrnd() async {
    likey = widget.time
        .toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      rnd = (prefs.getInt('${likey}') ??
          10000);
    });
  }

  _savernd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('${likey}', rnd); //likey에 like의 값을 저장함
  }

  void _rndsave() {
    setState(() {
      rnd = rnd + 1; //like의 값을 true로 바꿈
    });
    _savernd();
  }

  DateTime selectedDay = DateTime(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
    DateTime
        .now()
        .hour,
    DateTime
        .now()
        .minute,
    DateTime
        .now()
        .second,
    DateTime.now().millisecond
  );

  final _controller = TextEditingController();
  var _userEnterMessage = "";

  String key =
      "AAAAtk4SvvY:APA91bFUZOLIrqfWhdgMWQZUF5fNNryf7cO732Gdi8RFZ0cJZZkny53EuqwLqkO4PWgdfL82KDzZtm4ZeXiJrXsihPboSAj3aPEHxPJitiA6_KJLyyqQnxIcBSOw0SJxSfD--MY7CSM6";

  Future<void> sendNotification(Map<String, dynamic> messageData) async {
    final response = await http.post(
      Uri.https("fcm.googleapis.com", "fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "key=${key}",
      },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{
          'title': messageData['title'],
          'body': messageData['body'],
        },
        'priority': 'high',
        'data': messageData,
        'to': FirebaseAuth.instance.currentUser!.email.toString() ==
            widget.sender ? "${widget.author_token}" : "${widget.mytoken}",
      }),
    );
    if (response.statusCode != 200) {
      print("${response.statusCode}");
      throw Exception('Failed to send notification');
    }
  }

  void _sendMessage() async {
    await getToken();

    sendNotification(messageData!);

    await FirebaseFirestore.instance.collection("채팅").doc(
        "${widget.body} ${widget.time} ${widget.sender}").update({
      "text": FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.email.toString() ==
            widget.sender ? "${_userEnterMessage} ${rnd+10000}":
      "${_userEnterMessage} ${rnd}"
      ]),
      "userID": FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.email.toString() ==
            widget.sender ? "${FirebaseAuth.instance.currentUser!.email.toString()} ${rnd+10000}":
        "${FirebaseAuth.instance.currentUser!.email.toString()} ${rnd}"
      ]),
      "imageurl": FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.email.toString() ==
            widget.sender ? "${imageUrl} ${rnd+10000}":
      "${imageUrl} ${rnd}"]),

      "new":"${FirebaseAuth.instance.currentUser!.email.toString()}true",
      "time": selectedDay
    });

    _rndsave();


    _controller.clear();

    widget.scrollToTop();
    imageUrl = "nothing";
  }


  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImageFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImageFile != null)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 25,
              child: Center(
                child: Text("사진이 선택되었습니다."),
              ),
            ),
          );
        },
      );

    if (pickedImageFile == null)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 25,
              child: Center(
                child: Text("사진이 선택되지 않았습니다."),
              ),
            ),
          );
        },
      );

    Reference referenceRoot = FirebaseStorage.instance.ref(); //스토리지를 사용할건데

    Reference referenceDirImages = referenceRoot.child("images"); //image 폴더에

    Reference referenceImageToUpload = referenceDirImages.child(
        "${FirebaseAuth.instance.currentUser!.email
            .toString()} ${selectedDay}"); //유저이름 + 현재 시간으로 이미지 이름을 저장할거야

    try {
      await referenceImageToUpload.putFile(
          File(pickedImageFile!.path)); //그리고 그 이미지의 url을 가져와서 imageUrl 변수에 넣을게
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                pickImage();
              },
              icon: Icon(Icons.image, color: Colors.purple[200], size: 30,)),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                  labelText: "메시지를 입력하세요."
              ),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
              color: Colors.blueAccent,
              onPressed: _userEnterMessage
                  .trim()
                  .isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send)),


        ],
      ),
    );
  }
}
