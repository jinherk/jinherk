import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/drift/drift_database.dart';
import 'package:everynue/gyeongin/d_reply/newreply/new_reply.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CommentForm extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs;
  final int commentIndex;

  const CommentForm(
      {required this.postIndex,
      required this.postDocs,
      required this.commentDocs,
      required this.commentIndex,
      Key? key})
      : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: MediaQuery.of(context).size.width - 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(children: [
                Text(widget.commentDocs[widget.commentIndex]["commentBody"])
              ]), //댓글의 본문
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StreamBuilder<List<Comment>>(
                      stream: GetIt.I<LocalDatabase>().getComments(
                          widget.commentDocs[widget.commentIndex]
                              ["commentTime"],
                          widget.commentDocs[widget.commentIndex]
                              ["commentAuthor"]),
                      builder: (context, snapshot) {
                        return TextButton.icon(
                          onPressed: () {
                            ///좋아요를 안눌렀을 때 (데이터가 오긴하는데 비어있음)
                            if (snapshot.data!.isEmpty) {
                              FirebaseFirestore.instance
                                  .collection("경인교대(게시글)")
                                  .doc(
                                      "${widget.postDocs[widget.postIndex]["postBody"]} ${widget.postDocs[widget.postIndex]["postTime"]}")
                                  .collection("경인교대(댓글)")
                                  .doc(
                                      "${widget.commentDocs[widget.commentIndex]["commentTime"]}")
                                  .update(
                                      {"commentLike": FieldValue.increment(1)});
                              if (snapshot.data!.isNotEmpty) {
                                print(snapshot.data);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text("이미 좋아요를 눌렀어요!"),
                                      );
                                    });
                              }
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                          ),
                          label: widget.commentDocs[widget.commentIndex]
                                      ["commentLike"] ==
                                  0
                              ? Text("")
                              : Text(
                                  "${widget.commentDocs[widget.commentIndex]["commentLike"]}"),
                          style: TextButton.styleFrom(
                            primary: Colors.red,
                            maximumSize: Size(155, 40),
                          ),
                        );
                      }),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: NewReply(
                                  postIndex: widget.postIndex,
                                  postDocs: widget.postDocs,
                                  commentIndex: widget.commentIndex,
                                  commentDocs: widget.commentDocs),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "답글",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
