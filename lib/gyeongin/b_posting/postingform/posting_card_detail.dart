import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:everynue/drift/drift_database.dart';
import 'package:everynue/gyeongin/c_comment/commenthome/comment_home.dart';
import 'package:everynue/gyeongin/c_comment/newcomment/new_comment.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CardDetail extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  CardDetail({required this.postIndex, required this.postDocs, Key? key})
      : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  bool? isLike;
  final BoxDecoration boxDecoration = BoxDecoration(
    border: Border.all(color: Color(0xFFAEAEAE), width: 2),
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NewComment(
        postDocs: widget.postDocs,
        postIndex: widget.postIndex,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: 900,
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: boxDecoration,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      postingTop(),
                      postingMiddle(),
                    ],
                  ),
                ),
                CommentHome(
                    postDocs: widget.postDocs, postIndex: widget.postIndex),
              ],
            ),
          ),
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
            SizedBox(width: 10),
            Text(
              "??????",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            StreamBuilder<List<Posting>>(
                stream: GetIt.I<LocalDatabase>().getPostings(
                    widget.postDocs[widget.postIndex]["postTime"],
                    widget.postDocs[widget.postIndex]["postAuthor"]),
                builder: (context, snapshot) {
                  return IconButton(
                    onPressed: () {
                      ///???????????? ???????????? ??? (???????????? ??????????????? ????????????)
                      if (snapshot.data!.isEmpty) {
                        FirebaseFirestore.instance
                            .collection("????????????(?????????)")
                            .doc(
                            "${widget.postDocs[widget.postIndex]["postBody"]} ${widget.postDocs[widget.postIndex]["postTime"]}")
                            .update({"postLike": FieldValue.increment(1)});
                        GetIt.I<LocalDatabase>().saveLike(PostingsCompanion(
                            postLike: Value(true),
                            postTime: Value(
                                widget.postDocs[widget.postIndex]["postTime"]),
                            postAuthor: Value(widget.postDocs[widget.postIndex]
                            ["postAuthor"])));
                      }
                      ///???????????? ????????? ???
                      if (snapshot.data!.isNotEmpty) {
                        print(snapshot.data);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("?????? ???????????? ????????????!"),
                              );
                            });
                      }
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: snapshot.data!.isNotEmpty? Colors.red: Colors.grey
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }

  Widget postingMiddle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Wrap(
        children: [
          Text(
            widget.postDocs[widget.postIndex]["postBody"],
            //???????????? ??????
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
