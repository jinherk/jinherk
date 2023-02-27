import 'package:flutter/material.dart';

import '../gyeongin/a_homescreen/homescreen.dart';
import '../경인교대/GINUE_Home/GINUE_Home.dart';

enum EducationUniversity {
  gyeongin,
  gongju,
  gwangju,
  daegu,
  busan,
  seoul,
  jeonju,
  jinju,
  cheongju,
  chuncheon,
  gyowon,
  ihwa,
  jeju
}

List<String> WidgetTitle = [
  "경인교대 게시판",
  "공주교대 게시판",
  "광주교대 게시판",
  "대구교대 게시판",
  "부산교대 게시판",
  "서울교대 게시판",
  "전주교대 게시판",
  "진주교대 게시판",
  "청주교대 게시판",
  "춘천교대 게시판",
  "교원대 게시판",
  "이화여대 게시판",
  "제주대 게시판"
];

Widget CreatePageWidget(
    BuildContext context, EducationUniversity educationUniversity, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(
                "asset/img/${educationUniversity.toString().split('.').last.toLowerCase()}.jpg"),
            fit: BoxFit.fill),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${WidgetTitle[index]}",
                style: TextStyle(
                    color: Colors.grey[100], fontSize: 25, fontFamily: "main"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
