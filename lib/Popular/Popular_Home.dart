import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'Popular_Form.dart';
import 'Popular_List.dart';

class Popular_Home extends StatefulWidget {
  const Popular_Home({Key? key}) : super(key: key);

  @override
  State<Popular_Home> createState() => _Popular_HomeState();
}

class _Popular_HomeState extends State<Popular_Home> {
  String mytoken ="";

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
  @override
  void initState() {
    getToken();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Popular_List();
                  }));
                },
                child: Text(
                  "더보기",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance //인기글 스트리밍
                  .collection('인기글')
                  .orderBy("time", descending: true)
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    return Popular_Form(
                      body: chatDocs[index]["body"],
                      //게시글의 본문을 보냄
                      time: chatDocs[index]["time"],
                      //게시글의 작성 시간을 보냄
                      author: chatDocs[index]["author"],
                      //게시글의 작성자를 보냄
                      Realtime_Comment: chatDocs[index]["comment"],
                      //게시글의 댓글 수를 보냄
                      Realtime_Like: chatDocs[index]["like"],
                      order: chatDocs[index]["order"],
                      //게시글의 새삥 유저를 보냄
                      imageurl: chatDocs[index]["imageurl"],
                      //게시글 이미지 주소를 보냄
                      university: chatDocs[index]["university"], //게시글이 어디 게시판에서 쓰였는지 보냄
                      token: chatDocs[index]["토큰"],
                      mytoken: mytoken,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
