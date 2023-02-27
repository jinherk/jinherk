import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Popular_Form.dart';

class Popular_List extends StatefulWidget {
  const Popular_List({Key? key}) : super(key: key);

  @override
  State<Popular_List> createState() => _Popular_ListState();
}

class _Popular_ListState extends State<Popular_List> {
  String mytoken ="";

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
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance //인기글 스트리밍
              .collection('인기글')
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return Popular_Form(
                  body: chatDocs[index]["body"],
                  //게시글의 본문을 보냄
                  time: chatDocs[index]["time"],
                  //게시글의 작성 시간을 보냄
                  author: chatDocs[index]["author"],
                  //게시글의 작성자를 보냄
                  Realtime_Comment: chatDocs[index]["comment"],
                  //게시글의 댓글 수를 보냄
                  Realtime_Like: chatDocs[index]["like"],
                  order: chatDocs[index]["order"],
                  //게시글의 새삥 유저를 보냄
                  imageurl: chatDocs[index]["imageurl"],
                  //게시글 이미지 주소를 보냄
                  university: chatDocs[index]["university"],
                  //게시글이 어디 게시판에서 쓰였는지 보냄
                  token: chatDocs[index]["토큰"],
                  mytoken: mytoken,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
