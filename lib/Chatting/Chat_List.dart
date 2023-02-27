import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/Chatting/Chat_List_Form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat_List extends StatefulWidget {
  const Chat_List({Key? key}) : super(key: key);

  @override
  State<Chat_List> createState() => _Chat_ListState();
}

class _Chat_ListState extends State<Chat_List> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('채팅').orderBy("time", descending: true).snapshots(),
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
              DocumentSnapshot textdocument = snapshot.data!.docs[index];
              List<dynamic> multipleData = textdocument["text"];
              if (chatDocs[index]["게시자"] ==
                      FirebaseAuth.instance.currentUser!.email ||
                  chatDocs[index]["전송자"] ==
                      FirebaseAuth.instance.currentUser!.email) {
                return Chat_List_Form(
                  body: chatDocs[index]["mother_body"],
                  time: chatDocs[index]["mother_time"],
                  sender: chatDocs[index]["전송자"],
                  last: multipleData[multipleData.length - 1],
                  author_token: chatDocs[index]["게시자 토큰"],
                  mytoken: chatDocs[index]["전송자 토큰"],
                  nnew: chatDocs[index]["new"],
                  index: multipleData.length,
                );
              } else {
                return Text("");
              }
            });
      },
    );
  }
}
