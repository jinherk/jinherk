import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/const/colors.dart';
import 'package:everynue/gyeongin/b_posting/postingform/posting_form.dart';

import 'package:flutter/material.dart';
import '../newposting/new_posting.dart';

class PostingHome extends StatefulWidget {
  const PostingHome({Key? key}) : super(key: key);

  @override
  State<PostingHome> createState() => _PostingHomeState();
}

class _PostingHomeState extends State<PostingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderWriting(),
      body: renderPosting(),
    );
  }

  ///글쓰기 버튼
  Widget renderWriting() {
    return FloatingActionButton.extended(
      backgroundColor: red,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height - 20,
                child: NewPosting(),
              );
            });
      },
      icon: const Icon(Icons.create),
      label: const Text('글 쓰기'),
    );
  }

  ///스트림 빌더
  Widget renderPosting() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('경인교대(게시글)')
          .orderBy("postTime", descending: true)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final postDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: postDocs.length,
          itemBuilder: (context, index) {
            return PostingForm(postDocs: postDocs, postIndex: index);
          },
        );
      },
    );
  }
}
