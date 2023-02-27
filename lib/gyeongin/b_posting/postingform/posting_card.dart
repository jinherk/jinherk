import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/gyeongin/b_posting/postingform/posting_card_detail.dart';
import 'package:flutter/material.dart';

class PostingCard extends StatelessWidget {
  final BoxDecoration boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
  );
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  PostingCard({required this.postDocs, required this.postIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CardDetail(postIndex: postIndex, postDocs: postDocs);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width - 30,
        decoration: boxDecoration,
        child: Column(
          children: [
            postingTop(),
            postingMiddle(),
            postingBottom(),
          ],
        ),
      ),
    );
  }

  Widget postingTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              "asset/img/cat3.png",
              scale: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "익명",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          postDocs[postIndex]["postTime"].substring(0, 10), //게시글의 작성 시간
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget postingMiddle() {
    return SizedBox(
      height: postDocs[postIndex]["postBody"].length > 30 ? 150 : 80,
      //게시글이 30글자를 초과하면 높이 150, 30글자 미만이면 높이 100
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Text(postDocs[postIndex]["postBody"]),
            ),
          ],
        ),
      ),
    );
  }

  Widget postingBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "..더보기",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            Row(
              children: [
                Image.asset(
                  "asset/img/heart.png",
                  scale: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                if (postDocs[postIndex]["postLike"] != 0)
                  Text("${postDocs[postIndex]["postLike"]}",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "asset/img/comment.png",
                  scale: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                if (postDocs[postIndex]["postComment"] != 0)
                  Text("${postDocs[postIndex]["postComment"]}",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
