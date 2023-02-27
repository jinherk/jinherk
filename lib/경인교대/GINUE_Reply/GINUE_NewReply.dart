import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GINUE_NewReply extends StatefulWidget {
  String time; //댓글의 작성 시간을 받음
  String body; //댓글의 본문을 받음
  String author; //댓글의 작성자를 받음
  String token; //댓글의 토큰을 받음
  String mother_auther; //게시글의 작성자를 받음
  String mother_body; //게시글의 본문을 받음
  String mother_time; //게시글의 작성 시간을 받음
  String mother_token; //게시글의 토큰을 받음
  String imageurl; //게시글의 이미지 링크를 받음
  String university; //게시판을 받음
  int mother_comment; //게시글의 댓글 수를 받음
  int mother_like; //게시글의 좋아요 수를 받음
  int my_first_index; //나의 첫 인덱스를 받아옴
  int order; //내 인덱스를 정하기 위해서 게시글에 댓글을 단 사람 수를 받아옴
  VoidCallback indexsave; //댓글이나 답글을 처음 달면 이 함수를 통해 내 인덱스가 정해짐
  VoidCallback alreadysave; //댓글이나 답글을 처음 달았을 때 이 함수를 통해 앞으로의 인덱스가 nickname으로 고정됨
  bool already; //내가 이미 댓글이나 답글을 달았는지 정보를 받아옴

  GINUE_NewReply(
      {required this.body,
      required this.time,
      required this.mother_body,
      required this.mother_time,
      required this.alreadysave,
      required this.indexsave,
      required this.already,
      required this.order,
      required this.my_first_index,
      required this.token,
      required this.mother_like,
      required this.mother_comment,
      required this.imageurl,
      required this.university,
      required this.author,
      required this.mother_auther,
      required this.mother_token,
      Key? key})
      : super(key: key);

  @override
  State<GINUE_NewReply> createState() => _GINUE_NewReplyState();
}

class _GINUE_NewReplyState extends State<GINUE_NewReply> {
  String mytoken = "";

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

  @override
  void initState() {
    getToken();
    super.initState();
    messageData = {
      'title': 'EVERYNUE',
      'body': '답글이 달렸어요!',
      "Body": widget.mother_body,
      "time": widget.mother_time,
      "author": widget.mother_auther,
      "mother_comment": widget.mother_comment,
      "order": widget.order,
      "mother_like": widget.mother_like,
      "imageurl": widget.imageurl,
      "university": widget.university,
      "token": widget.mother_token,
      "mytoken": mytoken
    };
  }

  Map<String, dynamic>? messageData;

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
        'to': "${widget.token}",
      }),
    );
    if (response.statusCode != 200) {
      print("${response.statusCode}");
      throw Exception('Failed to send notification');
    }
  }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );

  final _Body_controller = TextEditingController();
  var _Body_Context = "";

  void _sendMessage() async{

    await getToken();

    if(FirebaseAuth.instance.currentUser!.email.toString() != widget.author )
    sendNotification(messageData!);

    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc("${widget.mother_body} ${widget.mother_time}")
        .update({"comment": FieldValue.increment(1)});

    if (widget.already == false) {
      widget.alreadysave();
      widget.indexsave();
      FirebaseFirestore.instance
          .collection("경인교대(게시글)")
          .doc("${widget.body} ${widget.time}")
          .update({"order": FieldValue.increment(1)});
    }

    FirebaseFirestore.instance
        .collection("경인교대(게시글)") //게시글 컬렉션의
        .doc(
            "${widget.mother_body} ${widget.mother_time}") // 게시글의 본문과 게시글의 작성 시간을 이름으로 하는 다큐먼트의
        .collection("경인교대(댓글)") // 하위 컬렉션인 댓글 컬렉션의
        .doc("${widget.time}") // 댓글의 작성 시간을 이름으로 하는 다큐먼트의
        .collection("경인교대(답글)") //하위 컬레션인 답글 컬렉션에
        .doc("${selectedDay}") // 답글 작성 시간을 이름으로 하는 다큐먼트를 생성
        .set({
      "body": _Body_Context,
      "time": selectedDay.toString(),
      "userID": FirebaseAuth.instance.currentUser!.email.toString(),
      "mother_body": widget.body,
      "mother_time": widget.time,
      "like": 0,
      "토큰": mytoken,
      if (widget.already == false &&
          widget.mother_auther == FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": "작성자",
      if (widget.already == true &&
          widget.mother_auther == FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": "작성자",
      if (widget.already == false &&
          widget.mother_auther != FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": widget.order,
      if (widget.already == true &&
          widget.mother_auther != FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": widget.my_first_index,
    });
    _Body_controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _Body_controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "댓글을 입력하세요.",
              ),
              onChanged: (value) {
                _Body_Context = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              color: Colors.blueAccent,
              onPressed: _Body_Context.trim().isEmpty ? null : _sendMessage,
              icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
