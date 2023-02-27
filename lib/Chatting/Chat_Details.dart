import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/Chatting/NewMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat_Details extends StatefulWidget {
  Chat_Details(
      {required this.body, required this.time, required this.sender, required this.author_token,required this.mytoken, Key? key})
      : super(key: key);
  final String body;
  final String time;
  final String sender;
  final String author_token;
  final String mytoken;

  @override
  State<Chat_Details> createState() => _Chat_DetailsState();
}

class _Chat_DetailsState extends State<Chat_Details> {
  final ScrollController scrollController = ScrollController();

  void scrollToTop() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.white,
                child: Chat_Details_Body(
                  body: widget.body,
                  time: widget.time,
                  scrollController: scrollController,
                  scrollToTop: scrollToTop,
                ),
              ),
            ),
            SingleChildScrollView(
              child: NewMessage(
                body: widget.body,
                time: widget.time,
                sender: widget.sender,
                author_token: widget.author_token,
                scrollToTop: scrollToTop,
                scrollController: scrollController,
                mytoken: widget.mytoken,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Chat_Details_Body extends StatefulWidget {
  //여기서 chatdocs[index]["body"] 받음
  Chat_Details_Body(
      {required this.body,
      required this.time,
      required this.scrollController,
      required this.scrollToTop,
      Key? key})
      : super(key: key);
  final String body;
  final String time;
  final ScrollController scrollController;
  VoidCallback scrollToTop;

  @override
  State<Chat_Details_Body> createState() => _Chat_Details_BodyState();
}

class _Chat_Details_BodyState extends State<Chat_Details_Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('채팅').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot textdocument = snapshot.data!.docs[index];
              List<dynamic> multipleData = textdocument["text"];
              DocumentSnapshot userdocument = snapshot.data!.docs[index];
              List<dynamic> multipleData2 = userdocument["userID"];
              DocumentSnapshot urldocument = snapshot.data!.docs[index];
              List<dynamic> multipleData3 = urldocument["imageurl"];

              if (chatDocs[index]["mother_body"] == widget.body &&
                  chatDocs[index]["mother_time"] == widget.time &&
                  chatDocs[index]["전송자"] ==
                      FirebaseAuth.instance.currentUser!.email) {
                return SizedBox(
                  height: 600,
                  child: Chat_Details_Body_Form(
                    message: multipleData,
                    isMe: multipleData2,
                    imageurl: multipleData3,
                    scrollController: widget.scrollController,
                    scrollToTop: widget.scrollToTop,
                  ),
                );
              } else if (chatDocs[index]["mother_body"] == widget.body &&
                  chatDocs[index]["mother_time"] == widget.time &&
                  chatDocs[index]["게시자"] ==
                      FirebaseAuth.instance.currentUser!.email) {
                return SizedBox(
                  height: 600,
                  child: Chat_Details_Body_Form(
                    scrollController: widget.scrollController,
                    scrollToTop: widget.scrollToTop,
                    message: multipleData,
                    isMe: multipleData2,
                    imageurl: multipleData3,
                  ),
                );
              } else {
                return Container(
                  width: 0.01,
                  height: 0.01,
                );
              }
            });
      },
    );
  }
}

class Chat_Details_Body_Form extends StatefulWidget {
  Chat_Details_Body_Form(
      {required this.message,
      required this.isMe,
      required this.scrollController,
      required this.scrollToTop,
      required this.imageurl,
      Key? key})
      : super(key: key);
  List<dynamic> message;
  List<dynamic> isMe;
  List<dynamic> imageurl;
  final ScrollController scrollController;
  VoidCallback scrollToTop;

  @override
  State<Chat_Details_Body_Form> createState() => _Chat_Details_Body_FormState();
}

class _Chat_Details_Body_FormState extends State<Chat_Details_Body_Form> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.message.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: widget.isMe[index].toString().substring(
                            0, widget.isMe[index].toString().length - 6) ==
                        FirebaseAuth.instance.currentUser!.email.toString()
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    width: widget.message[index].toString().length > 20
                        ? 200
                        : null,
                    decoration: BoxDecoration(
                      color: widget.isMe[index].toString().substring(0,
                                  widget.isMe[index].toString().length - 6) ==
                              FirebaseAuth.instance.currentUser!.email
                                  .toString()
                          ? Colors.blue[100]
                          : Colors.pink[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: widget.isMe[index].toString().substring(0,
                                    widget.isMe[index].toString().length - 6) ==
                                FirebaseAuth.instance.currentUser!.email
                                    .toString()
                            ? Radius.circular(0)
                            : Radius.circular(12),
                        bottomLeft: widget.isMe[index].toString().substring(0,
                                    widget.isMe[index].toString().length - 6) ==
                                FirebaseAuth.instance.currentUser!.email
                                    .toString()
                            ? Radius.circular(12)
                            : Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.message[index].toString().substring(
                              0, widget.message[index].toString().length - 6),
                          style: TextStyle(color: Colors.black),
                        ),
                        if (widget.imageurl[index].toString().substring(0,
                                widget.imageurl[index].toString().length - 6) !=
                            'nothing')
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: MediaQuery.of(context).size.height-200,
                                      width: MediaQuery.of(context).size.width-80,
                                      child: Image.network("${widget.imageurl[index]}",fit: BoxFit.contain,),
                                    )
                                  );
                                },
                              );
                            },
                              child: Image.network("${widget.imageurl[index]}"))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
