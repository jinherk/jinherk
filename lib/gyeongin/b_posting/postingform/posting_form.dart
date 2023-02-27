import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/gyeongin/b_posting/postingform/posting_card.dart';
import 'package:flutter/material.dart';


class PostingForm extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  const PostingForm({required this.postDocs, required this.postIndex, Key? key})
      : super(key: key);

  @override
  State<PostingForm> createState() => _PostingFormState();
}

class _PostingFormState extends State<PostingForm> {
  @override
  Widget build(BuildContext context) {
    return PostingCard(postDocs: widget.postDocs, postIndex: widget.postIndex);
  }
}
