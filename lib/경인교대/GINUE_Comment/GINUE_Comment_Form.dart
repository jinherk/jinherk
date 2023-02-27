import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Chatting/Chat_Details.dart';
import '../GINUE_Reply/GINUE_NewReply.dart';
import '../GINUE_Reply/GINUE_Reply_Form.dart';

class GINUE_Comment_Form extends StatefulWidget {
  //<받는 데이터>-----------------------------------------------------------------
  GINUE_Comment_Form(
      {required this.body,
      required this.time,
      required this.mother_body,
      required this.mother_time,
      required this.Realtime_Like,
      required this.author,
      required this.index,
      required this.already,
      required this.my_first_index,
      required this.nickname,
      required this.indexsave,
      required this.alreadysave,
      required this.order,
      required this.token,
      required this.mother_like,
      required this.mother_comment,
      required this.mother_university,
      required this.mother_imageurl,
      required this.mother_author,
      required this.mother_token,
      required this.mytoken,
      Key? key})
      : super(key: key);
  String mytoken;
  String body; //댓글의 본문을 받아옴
  String time; //댓글의 작성 시간을 받아옴
  String mother_body; //게시글의 본문을 받아옴
  String mother_time; //게시글의 작성 시간을 받아옴
  String mother_author; //게시글의 작성자를 받아옴
  int mother_like; //게시글의 좋아요 수를 받아옴
  int mother_comment; //게시글의 댓글 수를 받아옴
  String mother_imageurl; //게시글의 이미지 링크를 받아옴
  String mother_university; //게시판을 받아옴
  String mother_token; //게시판의 토큰을 받아옴
  String author; //댓글의 작성자를 받아옴
  String token; //댓글의 토큰을 받아옴
  int Realtime_Like; //댓글의 좋아요 수를 받아옴
  int index;
  int my_first_index; //나의 첫 인덱스를 받아옴
  dynamic nickname; //만약 내가 이미 댓글이나 답글을 달았으면 내 첫 인덱스로 댓글이나 답글을 달아야하니까 닉네임을 받아옴
  int order; //내 인덱스를 정하기 위해서 게시글에 댓글을 단 사람 수를 받아옴
  bool already; //내가 이미 댓글이나 답글을 달았는지 정보를 받아옴
  VoidCallback indexsave; //댓글이나 답글을 처음 달면 이 함수를 통해 내 인덱스가 정해짐
  VoidCallback
      alreadysave; //댓글이나 답글을 처음 달았을 때 이 함수를 통해 앞으로의 인덱스가 nickname으로 고정됨

  //----------------------------------------------------------------------------
  @override
  State<GINUE_Comment_Form> createState() => _GINUE_Comment_FormState();
}

class _GINUE_Comment_FormState extends State<GINUE_Comment_Form> {
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

  //이해안가면 GINUE_Posting_Form의 details 클래스의 <SharedPreference> 주석을 참조 ---
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

  _loadlike() async {
    likey = likey = widget.time + widget.author + "좋아요 데이터 베이스 이름";
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

  //____________________________________________________________________________
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        widget.mother_author == widget.author
                            ? "${widget.nickname}"
                            : "익명${widget.nickname ==0? widget.nickname +1 : widget.nickname}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                                "text": FieldValue.arrayUnion([
                                                  "안녕하세요! 운영자입니다. 바르고 고운말을 사용해주세요.${rnd}"
                                                ]),
                                                "userID": FieldValue.arrayUnion(
                                                    ["여섯 글자가 넘는 운영자 이메일"]),
                                                "imageurl":
                                                    FieldValue.arrayUnion([
                                                  'nothing ${rnd + 9980}'
                                                ]),
                                                "게시자 토큰": "${widget.token}",
                                                "전송자 토큰": mytoken,
                                                "new": "운영자true"
                                              });
                                            if (click == false)
                                              Navigator.of(context)
                                                  .pushReplacement(
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
                                                  },
                                                ),
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
                                                    "${widget.mother_body} ${widget.mother_time}")
                                                .collection("경인교대(댓글)")
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
                                                  "${widget.mother_body} ${widget.mother_time}")
                                              .collection("경인교대(댓글)")
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
                        icon:
                            Icon(Icons.more_vert_outlined, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(children: [Text(widget.body)]), //댓글의 본문
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      if (like == false) {
                        FirebaseFirestore.instance
                            .collection("경인교대(게시글)")
                            .doc("${widget.mother_body} ${widget.mother_time}")
                            .collection("경인교대(댓글)")
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
                            });
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
                              child: GINUE_NewReply(
                                author: widget.author,
                                mother_comment: widget.mother_comment,
                                mother_like: widget.mother_like,
                                university: widget.mother_university,
                                imageurl: widget.mother_imageurl,
                                body: widget.body,
                                //댓글의 본문을 보냄
                                time: widget.time,
                                //댓글의 작성 시간을 보냄 이유: 똑같은 본문의 댓글 때문에 중복 스트림되는 경우를 없애려고
                                mother_body: widget.mother_body,
                                //게시글의 본문을 보냄
                                mother_time: widget.mother_time,
                                //게시글의 작성 시간을 보냄
                                indexsave: widget.indexsave,
                                alreadysave: widget.alreadysave,
                                already: widget.already,
                                my_first_index: widget.my_first_index,
                                order: widget.order,
                                token: widget.token,
                                mother_auther: widget.mother_author,
                                mother_token: widget.mother_token,
                              ),
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
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("경인교대(게시글)") //게시글 컬렉션의
              .doc(
                  "${widget.mother_body} ${widget.mother_time}") //게시글의 본문과 게시글의 작성 시간을 이름으로 하는 다큐먼트의
              .collection("경인교대(댓글)") //하위 컬렉션인 댓글 컬렉션의
              .doc("${widget.time}") //댓글의 작성 시간을 이름으로 하는 다큐먼트의
              .collection("경인교대(답글)") //하위 컬레션인 답글 컬렉션을
              .orderBy("time", descending: true) //시간 순서대로 정렬한다.
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = snapshot.data!.docs;
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return GINUE_Reply_Form(
                  body: chatDocs[index]["body"],
                  //답글의 본문을 보냄
                  time: chatDocs[index]["time"],
                  //답글의 작성 시간을 보냄
                  mother_body: chatDocs[index]["mother_body"],
                  //댓글의 본문을 보냄
                  mother_time: chatDocs[index]["mother_time"],
                  //댓글의 작성 시간을 보냄
                  grand_mother_body: widget.mother_body,
                  //게시글의 본문을 보냄
                  grand_mother_time: widget.mother_time,
                  //게시글의 작성 시간을 보냄
                  Realtime_Like: chatDocs[index]["like"],
                  //답글의 좋아요 수를 보냄
                  author: chatDocs[index]["userID"],
                  //답글의 작성자를 보냄
                  nickname: chatDocs[index]["nickname"],
                  token: chatDocs[index]["토큰"],
                  mytoken: widget.mytoken,
                  grand_mother_author: widget.mother_author,
                );
              },
            );
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.grey[300],
        )
      ],
    );
  }
}
