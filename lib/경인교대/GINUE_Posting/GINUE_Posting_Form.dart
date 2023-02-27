import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everynue/Chatting/Chat_Details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GINUE_Comment/GINUE_Comment_Form.dart';
import '../GINUE_Comment/GINUE_NewComment.dart';
import '../GINUE_Home/GINUE_Home.dart';

class GINUE_Posting_Form extends StatefulWidget {
  //<받는 데이터>-----------------------------------------------------------------
  GINUE_Posting_Form(
      {required this.body,
      required this.time,
      required this.Realtime_Comment,
      required this.Realtime_Like,
      required this.author,
      required this.order,
      required this.imageurl,
      required this.university,
      required this.token,
      required this.index,
      required this.chatDocs,
      Key? key})
      : super(key: key);

  final String body; //게시글의 본문을 받음
  final String time; //게시글의 작성 시간을 받음
  final String author; //게시글의 작성자를 받음
  final String imageurl; //이미지 주소를 받음
  final String university; //게시판을 받음
  final String token; //게시글 토큰을 받음
  final int Realtime_Comment; //게시글의 댓글 수를 받음
  final int Realtime_Like; //게시글의 좋아요 수를 받음
  final int order; //게시글에 댓글이나 답글을 단 "사람" 수를 받음
  final int index;
  final chatDocs;

  //----------------------------------------------------------------------------
  @override
  State<GINUE_Posting_Form> createState() => _GINUE_Posting_FormState();
}

class _GINUE_Posting_FormState extends State<GINUE_Posting_Form> {
  String mytoken = "";

  getToken() async {
    //토큰 받아오기
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mytoken = token!; //mytoken에 내 토큰을 저장시킴 게시글 토큰이랑 다름.
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //<각 게시글의 양식>-----------------------------------------------------------
    return GestureDetector(
      onTap: () async {
        await getToken(); //게시글을 누른 사람의 토큰을 받아옴
        FirebaseFirestore.instance
            .collection("경인교대(게시글)")
            .doc("${widget.body} ${widget.time}")
            .update({"view": FieldValue.increment(1)}); //게시글을 누르면 조회수가 추가됨
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GINUE_details(
            // 게시글을 누르면 details 위젯으로 이동함
            body: widget.body,
            //게시글의 본문을 보냄
            time: widget.time,
            //게시글의 작성 시간을 보냄
            author: widget.author,
            //게시글의 작성자를 보냄
            mother_comment: widget.Realtime_Comment,
            //게시글의 댓글 수 를 보냄
            mother_like: widget.Realtime_Like,
            //게시글의 좋아요 수를 보냄
            order: widget.order,
            //게시글의 댓글이나 답글을 단 사람 수를 보냄
            imageurl: widget.imageurl,
            // 게시글의 이미지 주소를 보냄
            university: widget.university,
            //게시판을 보냄
            token: widget.token,
            //게시글의 토큰을 보냄
            mytoken: mytoken, //자신의 토큰을 보냄
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.time.substring(0, 10), //게시글의 작성 시간
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: widget.body.length > 30 ? 150 : 100,
              //게시글이 30글자를 초과하면 높이 150, 30글자 미만이면 높이 100
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(widget.chatDocs[widget.index]["body"])),
                    //게시글의 본문
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "..더보기",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            if (widget.imageurl != "")
                              Icon(
                                Icons.image,
                                size: 20,
                                color: Colors.grey,
                              )
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
                                widget.Realtime_Like == 0 //좋아요 수가 0이면
                                    ? Text("") //공백을 리턴
                                    : Text(
                                        "${widget.Realtime_Like}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
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
                                widget.Realtime_Comment == 0 //좋아요 매커니즘이랑 동일
                                    ? Text("")
                                    : Text(
                                        "${widget.Realtime_Comment}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    //<게시글 양식 끝>------------------------------------------------------------
  }
}

class GINUE_details extends StatefulWidget {
  //<받는 데이터>-----------------------------------------------------------------
  final String body; //게시글의 본문을 받음
  final String time; //게시글의 작성 시간을 받음
  final String author; //게시글의 작성자를 받음
  int mother_comment; //게시글의 댓글 수를 받음
  int mother_like; //게시글의 좋아요 수를 받음
  int order; //게시글에 댓글이나 답글을 단 사람 수를 받음
  String imageurl; //이미지 주소를 받음
  String university; //게시판을 받음
  String token; //게시글 토큰임
  String mytoken; //지금 내 토큰임

  GINUE_details(
      {required this.body,
      required this.time,
      required this.author,
      required this.mother_comment,
      required this.order,
      required this.imageurl,
      required this.university,
      required this.mother_like,
      required this.token,
      required this.mytoken,
      Key? key})
      : super(key: key);

  //----------------------------------------------------------------------------
  @override
  State<GINUE_details> createState() => _GINUE_detailsState();
}

class _GINUE_detailsState extends State<GINUE_details> {
  final List<String> manager = ["jinherk123@naver.com", "daon0@naver.com"];
  final String currentUser =
      FirebaseAuth.instance.currentUser!.email.toString();

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );

  int rnd = 10000;

  //<SharedPreference>__________________________________________________________
  String likey =
      "좋아요 여부를 담는 데이터 베이스 이름"; //초기 이름은 아무거나 상관없음 어차피 initState에서 이름을 바꿀것
  bool like = false;

  String clickey =
      "클릭 여부를 담는 데이터 베이스 이름"; //초기 이름은 아무거나 상관없음 어차피 initState에서 이름을 바꿀것
  bool click = false;

  String indexy =
      "자기 인덱스를 담는 데이터 베이스 이름"; //초기 이름은 아무거나 상관없음 어차피 initState에서 이름을 바꿀것
  int my_first_index = 0;

  String alreadyy =
      "댓글이나 답글 여부를 담는 데이터 베이스 이름"; //초기 이름은 아무거나 상관없음 어차피 initState에서 이름을 바꿀것
  bool already = false;

  @override
  void initState() {
    _loadlike(); //initState에 생성해야 위젯의 빌드 단계에서 자동으로 변수에 값이 들어감
    _loadclick(); //initState에 생성해야 위젯의 빌드 단계에서 자동으로 변수에 값이 들어감
    _loadindex(); //initState에 생성해야 위젯의 빌드 단계에서 자동으로 변수에 값이 들어감
    _loadalready(); //initState에 생성해야 위젯의 빌드 단계에서 자동으로 변수에 값이 들어감
    super.initState();
  }

  //왜 처음부터 데이터 베이스 이름을 정하지 않고, initstate에 와서 매번 계속 이름 지정해주냐면,
  //우리는 일단 고정적인 이름이 아니라 각 게시글마다 다른 데이터 베이스를 가지고 있어야함.
  //왜냐면 데이터 베이스 이름이 게시글 마다 특정되지 않고, 고정되있으면 a 게시글의 데이터 베이스랑 b,c,d,...z까지 다 공유됨.
  //그래서 게시글 마다 데이터 베이스를 따로 사용해야 a에서 좋아요 눌렀을 때, a에만 "이미 좋아요를 눌렀어요"가 뜰 수 있는거임.
  //이걸 위해서 데이터 베이스 이름을 각 게시글이 생성된 시간 + 게시글의 저자로 짓는거임.
  //게시글이 생성된 시간은 밀리 세컨드 단위로 측정되니 게시글이 생성된 시간은 조금씩이라도 다를 거고
  //만약 진짜 우연히 a와 b게시글이 생성된 시간이 밀리 세컨드 단위까지 같아도 둘의 저자는 다를 거임
  //게시글이 생성된 시간과 게시글의 저자가 같을 가능성은 무조건 0프로니까 이렇게 생성하면 어떤 일이 있어도 겹칠 수 없음
  //이렇게 하려면 widget.time 이랑 widget.author를 사용해야 하는데 변수에 widget. 값을 넣으려면
  //initState에서 선언하는 방법 밖에 없음

  _loadlike() async {
    likey = widget.time + widget.author + "좋아요 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      like = (prefs.getBool('${likey}') ?? false);
    });
  }

  _loadclick() async {
    clickey = widget.time + widget.author + "채팅 보내기 여부 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      click = (prefs.getBool('${clickey}') ?? false);
    });
  }

  _loadindex() async {
    indexy = widget.time + widget.author + "내 익명 인덱스를 저장하는 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      my_first_index = (prefs.getInt('${indexy}') ?? 0);
    });
  }

  _loadalready() async {
    alreadyy =
        indexy = widget.time + widget.author + "댓글,답글 여부를 저장하는 데이터 베이스 이름";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      already = (prefs.getBool('${alreadyy}') ?? false);
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

  _saveindex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('${indexy}', my_first_index);
  }

  _savealready() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('${alreadyy}', already);
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

  void indexsave() {
    my_first_index = widget.order;

    _saveindex();
  }

  void alreadysave() {
    already = true;

    _savealready();
  }

  GestureDetector startChat() {
    return GestureDetector(
      onTap: () async {
        //처음 채팅을 보내는 경우
        if (click == false) {
          FirebaseFirestore.instance
              .collection("채팅")
              .doc(
                  "${widget.body} ${widget.time} ${FirebaseAuth.instance.currentUser!.email}")
              .set({
            "mother_body": widget.body,
            "mother_time": widget.time,
            "게시자": widget.author,
            "전송자": FirebaseAuth.instance.currentUser!.email,
            "text": FieldValue.arrayUnion(
                ["안녕하세요! 운영자입니다. 바르고 고운말을 사용해주세요..${rnd}"]),
            "userID": FieldValue.arrayUnion(["여섯 글자가 넘는 운영자 이메일"]),
            "imageurl": FieldValue.arrayUnion(['nothing ${rnd + 9980}']),
            "게시자 토큰": widget.token,
            "전송자 토큰": widget.mytoken,
            "new": "운영자true",
            "time": selectedDay
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return Chat_Details(
                  sender: FirebaseAuth.instance.currentUser!.email!,
                  body: widget.body,
                  time: widget.time,
                  author_token: widget.token,
                  mytoken: widget.mytoken,
                );
              },
            ),
          );
        }
        if (click == true) {
          showDialog(
              context: context,
              builder: (context) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
                return AlertDialog(
                  content: Text("이미 채팅을 보내셨거나, 작성자가 채팅을 원하지 않아요!"),
                );
              });
          _clicksave();
        }
      },
      child: Container(
        color: Colors.grey[200],
        width: 220,
        height: 40,
        child: Center(
          child: Text("채팅하기"),
        ),
      ),
    );
  }

  GestureDetector report(){
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection(
            "경인교대(게시글)")
            .doc(
            "${widget.body} ${widget.time}")
            .update({
          "신고": FieldValue
              .increment(1)
        });
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    "신고하였습니다."),
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
    );
  }

  GestureDetector delete(){
    return  GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection(
            "경인교대(게시글)")
            .doc(
            "${widget.body} ${widget.time}")
            .delete()
            .whenComplete(() {});
        FirebaseFirestore.instance
            .collection("인기글")
            .doc(
            "${widget.university} ${widget.body} ${widget.time}")
            .delete()
            .whenComplete(() {
          Navigator.of(context)
              .pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return GINUE_Home();
              },
            ),
          );
        });
      },
      child: Text(
        "삭제",
        style: TextStyle(
            color: Colors.red,
            fontSize: 18),
      ),
    );
  }

  GestureDetector addPopular(){
    return GestureDetector(
      onTap: () {
        FirebaseFirestore.instance
            .collection("인기글")
            .doc(
            "${widget.university} ${widget.body} ${widget.time}")
            .set({
          "body": widget.body,
          "time": widget.time,
          "author": widget.author,
          "order": widget.order,
          "imageurl":
          widget.imageurl,
          "university":
          widget.university,
          'comment': widget
              .mother_comment,
          "like":
          widget.mother_like,
          "토큰": widget.token,
          "mytoken":
          widget.mytoken
        });
        Navigator.pop(context);
      },
      child: Text(
        "인기글에 추가",
        style: TextStyle(
            color: Colors.red,
            fontSize: 18),
      ),
    );
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GINUE_NewComment(
        author: widget.author,
        //게시글의 저자를 보냄
        body: widget.body,
        //게시글의 본문을 보냄
        time: widget.time,
        //게시글의 작성 시간을 보냄
        indexsave: indexsave,
        //인덱스 저장 함수를 보냄
        alreadysave: alreadysave,
        //댓글,답글 여부 저장 함수를 보냄
        my_first_index: my_first_index,
        //현재 내 익명 인덱스를 보냄
        already: already,
        //현재 내 댓글,답글 여부를 보냄
        order: widget.order,
        //현재 게시글에 댓글을 단 사람 수를 보냄
        token: widget.token,
        //게시글의 토큰을 보냄
        imageurl: widget.imageurl,
        //이미지 주소를 보냄
        university: widget.university,
        //게시판을 보냄
        mother_like: widget.mother_like,
        //게시글의 좋아요 수를 보냄
        mother_comment: widget.mother_comment, //게시글의 댓글 수를 보냄
      ),
      body: Container(
        height: 900,
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFAEAEAE), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
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
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (like == false) {
                                    FirebaseFirestore.instance
                                        .collection("경인교대(게시글)")
                                        .doc("${widget.body} ${widget.time}")
                                        .update(
                                            {"like": FieldValue.increment(1)});
                                    _likesave(); //좋아요를 눌렀으니까 like를 true로 바꿔줌
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
                                  color:
                                      like == false ? Colors.grey : Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (widget.author != currentUser ||
                                      widget.author == manager[0] ||
                                      widget.author == manager[1])
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Container(
                                            width: 200,
                                            height: 100,
                                            child: Column(
                                              children: [
                                                if (currentUser != manager[0] &&
                                                    currentUser != manager[1])
                                                  startChat(),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                if (currentUser != manager[0] &&
                                                    currentUser != manager[1])
                                                  report(),
                                                if (currentUser == manager[0] ||
                                                    currentUser == manager[1])
                                                  delete(),
                                                if (currentUser == manager[0] ||
                                                    currentUser == manager[1])
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                if (currentUser == manager[0] ||
                                                    currentUser == manager[1])
                                                  addPopular(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  if (widget.author == currentUser)
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 25,
                                            child: Center(
                                              child: delete()
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                },
                                icon: Icon(Icons.more_vert_outlined,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        children: [
                          Text(
                            widget.body, //게시글의 본문
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      if (widget.imageurl != "")
                        Image.network("${widget.imageurl}"),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              detail_body(
                mother_body: widget.body,
                //게시글의 본문을 보냄
                mother_time: widget.time,
                //게시글의 작성 시간을 보냄
                my_first_index: my_first_index,
                //자기가 첫번째로 부여 받은 인덱스를 보냄
                already: already,
                //만약 댓글을 한번 남겼으면 true가 가겠지
                mother_imageurl: widget.imageurl,
                mother_token: widget.token,
                mother_author: widget.author,
                mother_comment: widget.mother_comment,
                mother_like: widget.mother_like,
                mother_university: widget.university,
                indexsave: indexsave,
                alreadysave: alreadysave,
                order: widget.order,
                mytoken: widget.mytoken,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class detail_body extends StatefulWidget {
  //<받는 데이터>-----------------------------------------------------------------
  String mother_body; //게시글의 본문을 받음
  String mother_time; //게시글의 작성 시간을 받음
  String mother_author; //게시글의 작성자를 받아옴
  String mother_token; //게시판의 토큰을 받아옴
  String mother_university; //게시판을 받아옴
  String mother_imageurl; //게시글의 이미지 링크를 받아옴
  String mytoken; //자신의 토큰을 받아옴
  int mother_like; //게시글의 좋아요 수를 받아옴
  int mother_comment; //게시글의 댓글 수를 받아옴
  int my_first_index; //나의 첫 인덱스를 받아옴
  int order; //내 인덱스를 정하기 위해서 게시글에 댓글을 단 사람 수를 받아옴
  bool already; //내가 이미 댓글이나 답글을 달았는지 정보를 받아옴
  VoidCallback indexsave; //댓글이나 답글을 처음 달면 이 함수를 통해 내 인덱스가 정해짐
  VoidCallback
      alreadysave; //댓글이나 답글을 처음 달았을 때 이 함수를 통해 앞으로의 인덱스가 nickname으로 고정됨

  detail_body(
      {required this.mother_body,
      required this.mother_time,
      required this.my_first_index,
      required this.already,
      required this.alreadysave,
      required this.indexsave,
      required this.order,
      required this.mother_token,
      required this.mother_author,
      required this.mother_comment,
      required this.mother_like,
      required this.mother_imageurl,
      required this.mother_university,
      required this.mytoken,
      Key? key})
      : super(key: key);

  //----------------------------------------------------------------------------
  @override
  State<detail_body> createState() => _detail_bodyState();
}

class _detail_bodyState extends State<detail_body> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("경인교대(게시글)") //게시글 컬렉션의
          .doc(
              "${widget.mother_body} ${widget.mother_time}") //게시글의 본문과 게시글의 작성 시간을 이름으로 하는 다큐먼트의
          .collection("경인교대(댓글)") //하위 컬렉션인 댓글 컬렉션을
          .orderBy("time") //시간 순으로 정렬한다.
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
          controller: scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return GINUE_Comment_Form(
              body: chatDocs[index]["body"],
              //댓글의 본문을 보냄
              time: chatDocs[index]["time"],
              //댓글의 생성 시간을 보냄
              Realtime_Like: chatDocs[index]["like"],
              //댓글의 좋아요 수를 보냄
              author: chatDocs[index]["userID"],
              //댓글의 작성자를 보냄
              mother_body: widget.mother_body,
              //게시글의 본문을 보냄
              mother_time: widget.mother_time,
              //게시글의 생성 시간을 보냄
              mother_like: widget.mother_like,
              mother_comment: widget.mother_comment,
              mother_author: widget.mother_author,
              mother_token: widget.mother_token,
              mother_university: widget.mother_university,
              mother_imageurl: widget.mother_imageurl,
              index: index,
              my_first_index: widget.my_first_index,
              already: widget.already,
              nickname: chatDocs[index]["nickname"],
              indexsave: widget.indexsave,
              alreadysave: widget.alreadysave,
              order: widget.order,
              token: chatDocs[index]["토큰"],
              mytoken: widget.mytoken,
            );
          },
        );
      },
    );
  }
}
