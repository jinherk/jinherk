import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/Chatting/Chat_Details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat_List_Form extends StatefulWidget {
  Chat_List_Form(
      {required this.body,
      required this.time,
      required this.sender,
      required this.last,
      required this.author_token,
      required this.mytoken,
      required this.nnew,
      required this.index,
      Key? key})
      : super(key: key);
  final String body;
  final String time;
  final String sender;
  final String last;
  final String author_token;
  final String mytoken;
  final String nnew;
  final int index;

  @override
  State<Chat_List_Form> createState() => _Chat_List_FormState();
}

class _Chat_List_FormState extends State<Chat_List_Form> {
  String indexchecking = "아무거나 어차피 initsate에서 이름 새로 정해줄 거임";
  int checked_index = 0;

  @override
  void initState() {
    _loadindexchekcing();
    super.initState();
  }

  _loadindexchekcing() async {
    indexchecking =
        widget.time + FirebaseAuth.instance.currentUser!.email.toString() + "5";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      checked_index = (prefs.getInt('${indexchecking}') ?? 0);
    });
  }

  _saveindex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('${indexchecking}', checked_index); //likey에 like의 값을 저장함
  }

  void _likesave() {
    setState(() {
      checked_index = widget.index;
    });
    _saveindex();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("채팅")
                        .doc("${widget.body} ${widget.time} ${widget.sender}")
                        .delete()
                        .whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("채팅방 나가기(더이상 채팅이 오지 않습니다.)"),
                ),
              );
            });
      },
      onTap: () {
        _likesave();
        FirebaseFirestore.instance
            .collection("채팅")
            .doc("${widget.body} ${widget.time} ${widget.sender}")
            .update({
          "new": "${FirebaseAuth.instance.currentUser!.email.toString()}true"
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Chat_Details(
              body: widget.body,
              time: widget.time,
              sender: widget.sender,
              author_token: widget.author_token,
              mytoken: widget.mytoken,
            ); //여기에 chatdocs[index]["body"] 받음줌
          }),
        );
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12, left: 10),
                        child: Image.asset(
                          "asset/img/cat3.png",
                          scale: 13,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "익명",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  if (widget.nnew !=
                      "${FirebaseAuth.instance.currentUser!.email.toString()}true")
                    Row(
                      children: [
                        if(checked_index != widget.index)
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 65,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.last.substring(0, widget.last.length < 20 ? widget.last.length - 6 : widget.last.length - (widget.last.length - (widget.last.length - 20)))}",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
