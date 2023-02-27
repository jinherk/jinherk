import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Chatting/Chat_Details.dart';

class GINUE_Reply_Form extends StatefulWidget {
  //<받는 데이터>-----------------------------------------------------------------
  final String grand_mother_body;
  final String grand_mother_time;
  final String grand_mother_author;
  final String body; //답글의 본문을 받음
  final String time; //답글의 작성 시간을 받음
  final String author; //답글의 작성자를 받음
  final String token;
  final String mother_body;
  final String mother_time; //댓글의 본문을 받음
  final String mytoken;
  final int Realtime_Like; //답글의 좋아요 수를 받음
  dynamic nickname;

  GINUE_Reply_Form(
      {required this.grand_mother_body,
      required this.grand_mother_time,
      required this.body,
      required this.time,
      required this.mother_body,
      required this.mother_time,
      required this.Realtime_Like,
      required this.author,
      required this.nickname,
      required this.token,
      required this.mytoken,
      required this.grand_mother_author,
      Key? key})
      : super(key: key);

  //----------------------------------------------------------------------------
  @override
  State<GINUE_Reply_Form> createState() => _GINUE_Reply_FormState();
}

class _GINUE_Reply_FormState extends State<GINUE_Reply_Form> {
  String mytoken = "";

  getToken() async {
    //토큰 받아오기
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mytoken = token!;
        });
      },
    );
  }

  //이해안가면 BNUE_Posting_Form의 details 클래스의 <SharedPreference> 주석을 참조 ---
  String likey = "좋아요 여부를 담는 데이터 베이스 이름";
  bool like = false;
  String clickey = "클릭 여부를 담는 데이터 베이스 이름";
  bool click = false;
  int rnd = 10000;

  @override
  void initState() {
    getToken();
    _loadlike();
    _loadclick();
    super.initState();
  }

  Future<void> resetSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${likey}');
  }

  _loadlike() async {
    likey =  widget.time + widget.author + "좋아요 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      like = (prefs.getBool('${likey}') ?? false);
    });
  }

  _loadclick() async {
    clickey = widget.time + widget.author + "채팅 보내기 여부 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      click = (prefs.getBool('${clickey}') ??
          false);
    });
  }

  _savelike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('${likey}', like);
  }

  _saveclick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('${clickey}', click);
  }

  void _likesave() {
    setState(() {
      like = true;
    });
    _savelike();
  }

  void _clicksave() {
    setState(() {
      click = true;
    });
    _saveclick();
  }

  //----------------------------------------------------------------------------

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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                            widget.grand_mother_author == widget.author
                                ? "${widget.nickname}"
                                : "익명${widget.nickname}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (widget.author !=
                                  FirebaseAuth.instance.currentUser!.email)
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        width: 200,
                                        height: 100,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (click == false)
                                                  FirebaseFirestore.instance
                                                      .collection("채팅")
                                                      .doc(
                                                          "${widget.body} ${widget.time} ${FirebaseAuth.instance.currentUser!.email}")
                                                      .set({
                                                    "mother_body": widget.body,
                                                    "mother_time": widget.time,
                                                    "게시자": widget.author,
                                                    "전송자": FirebaseAuth.instance
                                                        .currentUser!.email,
                                                    "text":
                                                        FieldValue.arrayUnion([
                                                      "안녕하세요! 운영자입니다. 바르고 고운말을 사용해주세요.${rnd}"
                                                    ]),
                                                    "userID":
                                                        FieldValue.arrayUnion([
                                                      "여섯 글자가 넘는 운영자 이메일"
                                                    ]),
                                                    "imageurl":
                                                        FieldValue.arrayUnion([
                                                      'nothing ${rnd + 9980}'
                                                    ]),
                                                    "게시자 토큰": "${widget.token}",
                                                    "전송자 토큰": mytoken,
                                                    "new": "운영자true"
                                                  });
                                                if(click == false)
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                          return Chat_Details(
                                                            sender: FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .email!,
                                                            body: widget.body,
                                                            time: widget.time,
                                                            author_token:
                                                            widget.token,
                                                            mytoken: widget.mytoken,
                                                          );
                                                        }),
                                                  );
                                                if (click == true)
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text(
                                                              "이미 채팅을 보내셨거나, 작성자가 채팅을 원하지 않아요!"),
                                                        );
                                                      });
                                                _clicksave();
                                              },
                                              child: Container(
                                                color: Colors.grey[200],
                                                width: 220,
                                                height: 40,
                                                child: Center(
                                                  child: Text("채팅하기"),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection("경인교대(게시글)")
                                                    .doc(
                                                        "${widget.grand_mother_body} ${widget.grand_mother_time}")
                                                    .collection("경인교대(댓글)")
                                                    .doc(
                                                        "${widget.mother_time}")
                                                    .collection("경인교대(답글)")
                                                    .doc("${widget.time}")
                                                    .update({
                                                  "신고": FieldValue.increment(1)
                                                });
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Text("신고하였습니다."),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                color: Colors.grey[200],
                                                width: 220,
                                                height: 40,
                                                child: Center(
                                                  child: Text("신고하기"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              if (widget.author ==
                                  FirebaseAuth.instance.currentUser!.email)
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        height: 25,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection("경인교대(게시글)")
                                                  .doc(
                                                      "${widget.grand_mother_body} ${widget.grand_mother_time}")
                                                  .collection("경인교대(댓글)")
                                                  .doc("${widget.mother_time}")
                                                  .collection("경인교대(답글)")
                                                  .doc("${widget.time}")
                                                  .delete()
                                                  .whenComplete(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "삭제하기",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                            },
                            icon: Icon(Icons.more_vert_outlined,
                                color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(children: [Text(widget.body)]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          if (like == false) {
                            FirebaseFirestore.instance
                                .collection("경인교대(게시글)")
                                .doc(
                                    "${widget.grand_mother_body} ${widget.grand_mother_time}")
                                .collection("경인교대(댓글)")
                                .doc("${widget.mother_time}")
                                .collection("경인교대(답글)")
                                .doc("${widget.time}")
                                .update({"like": FieldValue.increment(1)});
                            _likesave();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("이미 좋아요를 눌렀어요!"),
                                );
                              },
                            );
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: like == false ? Colors.grey : Colors.red,
                        ),
                        label: widget.Realtime_Like == 0
                            ? Text("")
                            : Text("${widget.Realtime_Like}"),
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
