import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/const/colors.dart';
import 'package:flutter/material.dart';
import '../../e_clean/for_clean_code.dart';

class NewComment extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  const NewComment({required this.postDocs, required this.postIndex, Key? key})
      : super(key: key);

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final commentController = TextEditingController();
  var bodyText = "";
  ForNewComment? forNew;

  @override
  void didChangeDependencies() {
    forNew = ForNewComment(
        context: context,
        postDocs: widget.postDocs,
        postIndex: widget.postIndex);
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
            child: Padding(
              padding: forNew!.viewInsets!,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: commentController,
                decoration: forNew!.inputDecoration,
                onChanged: (value) {
                  setState(() {
                    bodyText = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: forNew!.viewInsets!,
            child: IconButton(
                color: bodyText.isEmpty ? grey : red,
                onPressed: bodyText.isEmpty
                    ? null
                    : () => forNew!.uploadComment(bodyText, commentController),
                icon: Icon(Icons.send)),
          ),
        ],
      ),
    );
  }
}
