import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/gyeongin/d_reply/replyform/replyform.dart';
import 'package:flutter/material.dart';

class ReplyHome extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs;
  final int commentIndex;

  const ReplyHome(
      {required this.postIndex,
      required this.postDocs,
      required this.commentDocs,
      required this.commentIndex,
      Key? key})
      : super(key: key);

  @override
  State<ReplyHome> createState() => _ReplyHomeState();
}

class _ReplyHomeState extends State<ReplyHome> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("경인교대(게시글)")
          .doc(
              "${widget.postDocs[widget.postIndex]["postBody"]} ${widget.postDocs[widget.postIndex]["postTime"]}")
          .collection("경인교대(댓글)")
          .doc(
              "${widget.commentDocs[widget.commentIndex]["commentTime"]}")
          .collection("경인교대(답글)")
          .orderBy("replyTime")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final replyDocs = snapshot.data!.docs;
        return ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: replyDocs.length,
          itemBuilder: (context, index) {
            return ReplyForm(replyDocs: replyDocs, replyIndex: index);
          },
        );
      },
    );
  }
}
