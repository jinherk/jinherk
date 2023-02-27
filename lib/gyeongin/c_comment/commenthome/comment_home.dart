import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/gyeongin/c_comment/commentform/comment_form.dart';
import 'package:everynue/gyeongin/d_reply/replyhome/reply_home.dart';
import 'package:flutter/material.dart';

class CommentHome extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  const CommentHome({required this.postDocs, required this.postIndex, Key? key})
      : super(key: key);

  @override
  State<CommentHome> createState() => _CommentHomeState();
}

class _CommentHomeState extends State<CommentHome> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("경인교대(게시글)")
          .doc(
          "${widget.postDocs[widget.postIndex]["postBody"]} ${widget
              .postDocs[widget.postIndex]["postTime"]}")
          .collection("경인교대(댓글)")
          .orderBy("commentTime")
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final commentDocs = snapshot.data!.docs;
        return ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: commentDocs.length,
          itemBuilder: (context, index) {
            return CommentForm(
                postIndex: widget.postIndex,
                postDocs: widget.postDocs,
                commentDocs: commentDocs,
                commentIndex: index);
          },
          separatorBuilder: (context, index) {
            return ReplyHome(postIndex: widget.postIndex, postDocs: widget.postDocs, commentDocs: commentDocs, commentIndex: index);
          },
        );
      },
    );
  }
}
