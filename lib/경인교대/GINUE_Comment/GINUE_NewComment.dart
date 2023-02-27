import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class GINUE_NewComment extends StatefulWidget {
  String author;
  String body; //게시글의 본문을 받음
  String time; //게시글의 작성 시간을 받음
  VoidCallback indexsave;
  VoidCallback alreadysave;
  bool already;
  int my_first_index;
  int order;
  int mother_comment;
  int mother_like;
  String imageurl;
  String university;
  String token;

  GINUE_NewComment(
      {required this.body,
      required this.time,
      required this.indexsave,
      required this.alreadysave,
      required this.already,
      required this.my_first_index,
      required this.order,
      required this.token,
      required this.author,
      required this.mother_like,
      required this.mother_comment,
      required this.imageurl,
      required this.university,
      Key? key})
      : super(key: key);

  @override
  State<GINUE_NewComment> createState() => _GINUE_NewCommentState();
}

class _GINUE_NewCommentState extends State<GINUE_NewComment> {
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

  @override
  void initState() {
    getToken();
    super.initState();
    messageData = {
      'title': 'EVERYNUE',
      'body': '댓글이 달렸어요!',
      "Body": widget.body,
      "time": widget.time,
      "author": widget.author,
      "mother_comment": widget.mother_comment,
      "order": widget.order,
      "mother_like": widget.mother_like,
      "imageurl": widget.imageurl,
      "university": widget.university,
      "token": widget.token,
      "mytoken": mytoken
    };
  }

  Map<String, dynamic>? messageData;

  void _sendMessage() async {
    await getToken();

    if(FirebaseAuth.instance.currentUser!.email.toString() != widget.author )
    sendNotification(messageData!);

    setState(() {
      selectedDay = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour + 9,
        DateTime.now().minute,
        DateTime.now().second,
      );
    });

    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc("${widget.body} ${widget.time}")
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
        .collection("경인교대(게시글)")
        .doc("${widget.body} ${widget.time}")
        .collection("경인교대(댓글)")
        .doc("${selectedDay}")
        .set({
      "body": _Body_Context,
      //댓글의 본문을 추가함
      "time": selectedDay.toString(),
      //댓글 작성 시간을 추가함
      "userID": FirebaseAuth.instance.currentUser!.email.toString(),
      //작성자의 이메일을 추가함
      "mother_body": widget.body,
      //게시글의 본문을 추가함
      "mother_time": widget.time,
      //게시글의 작성 시간을 추가함
      "like": 0,
      "토큰": mytoken,
      if (widget.already == false &&
          widget.author == FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": "작성자",
      if (widget.already == true &&
          widget.author == FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": "작성자",
      if (widget.already == false &&
          widget.author != FirebaseAuth.instance.currentUser!.email.toString()
      ) "nickname": widget.order,
      if (widget.already == true &&
          widget.author != FirebaseAuth.instance.currentUser!.email.toString()
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
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _Body_controller,
                decoration: InputDecoration(
                  labelText: "댓글을 입력하세요.",
                ),
                onChanged: (value) {
                  setState(() {
                    _Body_Context = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: IconButton(
                color: Colors.red[400],
                onPressed: _Body_Context.trim().isEmpty ? null : _sendMessage,
                icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }
}
