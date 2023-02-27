import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../testmodel.dart';
import '../GINUE_Posting/GINUE_Posting_Form.dart';

class GINUE_Best extends StatefulWidget {
  GINUE_Best({Key? key}) : super(key: key);

  @override
  State<GINUE_Best> createState() => _GINUE_BestState();
}

class _GINUE_BestState extends State<GINUE_Best> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(

        stream: FirebaseFirestore.instance //부산교대(게시글 컬렉션을) 스트리밍
            .collection('경인교대(게시글)')
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
              if(chatDocs[index]["comment"] > 3){
                return GINUE_Posting_Form(
                  body: chatDocs[index]["body"], //게시글의 본문을 보냄
                  time: chatDocs[index]["time"], //게시글의 작성 시간을 보냄
                  author: chatDocs[index]["userID"], //게시글의 작성자를 보냄
                  Realtime_Comment: chatDocs[index]["comment"], //게시글의 댓글 수를 보냄
                  Realtime_Like: chatDocs[index]["like"], //게시글의 좋아요 수를 보냄
                  order: chatDocs[index]["order"],
                  imageurl: chatDocs[index]["image"],
                  university: chatDocs[index]["university"],
                  token: chatDocs[index]["토큰"],
                  index: index,
                  chatDocs: chatDocs,
                );
              }else {
                return Container(
                  width: 0.01,
                  height: 0.01,
                );
              }
            },
          );
        },
      ),
    );
  }
}