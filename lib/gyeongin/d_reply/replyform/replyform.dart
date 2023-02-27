import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReplyForm extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> replyDocs;
  final int replyIndex;
  const ReplyForm({required this.replyDocs, required this.replyIndex, Key? key}) : super(key: key);

  @override
  State<ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    "asset/img/arrow.png",
                    scale: 10,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              margin: EdgeInsets.only(left: 15, bottom: 5),
              width: MediaQuery.of(context).size.width - 65,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
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
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(children: [Text(widget.replyDocs[widget.replyIndex]["replyBody"])]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                         },
                        icon: Icon(
                          Icons.favorite,
                          color:  Colors.grey ,
                        ),
                        label: widget.replyDocs[widget.replyIndex]["replyLike"] == 0
                            ? Text("")
                            : Text("${widget.replyDocs[widget.replyIndex]["replyLike"]}"),
                        style: TextButton.styleFrom(
                          primary: Colors.red,
                          maximumSize: Size(155, 40),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
