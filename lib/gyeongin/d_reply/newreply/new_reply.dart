import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../e_clean/for_clean_code.dart';

class NewReply extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs;
  final int commentIndex;

  const NewReply({required this.postIndex,
    required this.postDocs,
    required this.commentIndex,
    required this.commentDocs,
    Key? key})
      : super(key: key);

  @override
  State<NewReply> createState() => _NewReplyState();
}

class _NewReplyState extends State<NewReply> {
  final replyController = TextEditingController();
  var replyText = "";
  ForNewReply? forNew;

  @override
  void didChangeDependencies() {
    forNew = ForNewReply(
        postIndex: widget.postIndex,
        postDocs: widget.postDocs,
        commentDocs: widget.commentDocs,
        commentIndex: widget.commentIndex,
        context: context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: forNew!.width,
      padding: forNew!.padding,
      margin: forNew!.margin,
      decoration: forNew!.boxDecoration,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: replyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "댓글을 입력하세요.",
              ),
              onChanged: (value) {
                replyText = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              color: Colors.blueAccent,
              onPressed: replyText
                  .trim()
                  .isEmpty ? null : ()=> forNew!.uploadReply(replyText,replyController,context),
              icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
