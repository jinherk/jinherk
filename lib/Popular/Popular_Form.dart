import 'package:everynue/Screen/Index0.dart';
import 'package:flutter/material.dart';
import '../경인교대/GINUE_Posting/GINUE_Posting_Form.dart';
class Popular_Form extends StatefulWidget {
  final String body; //게시글의 본문을 받음
  final String time; //게시글의 작성 시간을 받음
  final String author; //게시글의 작성자를 받음
  int Realtime_Comment; //게시글의 댓글 수를 받음
  int Realtime_Like; //게시글의 좋아요 수를 받음
  int order;
  String imageurl;
  String university;
  String token;
  String mytoken;

  Popular_Form(
      {required this.body,
      required this.time,
      required this.author,
      required this.Realtime_Comment,
      required this.order,
      required this.imageurl,
      required this.university,
      required this.Realtime_Like,
        required this.token,
        required this.mytoken,
      Key? key})
      : super(key: key);

  @override
  State<Popular_Form> createState() => _Popular_FormState();
}

class _Popular_FormState extends State<Popular_Form> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (widget.university == "부산교대") {
                return Text("dd");
              } else if (widget.university == "경인교대") {
                return GINUE_details(
                  body: widget.body,
                  time: widget.time,
                  author: widget.author,
                  mother_comment: widget.Realtime_Comment,
                  order: widget.order,
                  imageurl: widget.imageurl,
                  university: widget.university,
                  mother_like: widget.Realtime_Like,
                  token: widget.token,
                  mytoken: widget.mytoken,

                );
              } else if (widget.university == "공주교대") {
                return Text("dd");
              } else if (widget.university == "광주교대") {
                return Text("dd");
              } else if (widget.university == "대구교대") {
                return Text("dd");
              } else if (widget.university == "서울교대") {
                return Text("dd");
              } else if (widget.university == "전주교대") {
                return Text("dd");
              } else if (widget.university == "진주교대") {
                return Text("dd");
              } else if (widget.university == "청주교대") {
                return Text("dd");
              } else if (widget.university == "춘천교대") {
                return Text("dd");
              } else if (widget.university == "제주대") {
                return Text("dd");
              } else if (widget.university == "이화여대") {
                return Text("dd");
              } else if (widget.university == "교원대") {
                return Text("dd");
              } else {
                return const index0();
              }
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 110,
        decoration: const BoxDecoration(),
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
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "익명",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.university, //게시글의 작성 시간
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(widget.body)), //게시글의 본문
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            if (widget.imageurl != "")
                              const Icon(
                                Icons.image,
                                size: 20,
                                color: Colors.grey,
                              )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 2,
            )
          ],
        ),
      ),
    );
  }
}
