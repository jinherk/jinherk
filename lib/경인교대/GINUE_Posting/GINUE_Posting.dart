
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'GINUE_NewPosting.dart';
import 'GINUE_Posting_Form.dart';


class GINUE_Posting extends StatefulWidget {
  GINUE_Posting({Key? key}) : super(key: key);

  @override
  State<GINUE_Posting> createState() => _GINUE_PostingState();
}

class _GINUE_PostingState extends State<GINUE_Posting> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red[400],
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child:  GINUE_NewPosting(),
                );
              });
        },
        icon: const Icon(Icons.create),
        label: const Text('글 쓰기'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
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
              return GINUE_Posting_Form(
                body: chatDocs[index]["body"], //게시글의 본문을 보냄
                time: chatDocs[index]["time"], //게시글의 작성 시간을 보냄
                author: chatDocs[index]["userID"], //게시글의 작성자를 보냄
                Realtime_Comment: chatDocs[index]["comment"], //게시글의 댓글 수를 보냄
                Realtime_Like: chatDocs[index]["like"], //게시글의 좋아요 수를 보냄
                order: chatDocs[index]["order"],  //게시글에 댓글이나 답글을 단 사람 수를 보냄
                imageurl: chatDocs[index]["image"], //이미지 주소를 보냄
                university: chatDocs[index]["university"], //게시판을 보냄
                token: chatDocs[index]["토큰"], //게시글 토큰을 보냄
                index: index,
                chatDocs: chatDocs,
              );
            },
          );
        },
      ),
    );
  }
}