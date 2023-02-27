import 'package:flutter/material.dart';

class Private extends StatelessWidget {
  const Private({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "수집하는 개인정보",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "1. 학교 이메일",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "교육대학교 재학생 인증 및 회원 식별에 사용됩니다.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "2. 본명",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "친구 추가 서비스에 사용됩니다.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "개인정보 처리 위탁",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "저희 EVERYNUE는 Uber, Twitter, Instagram, Spotify, 등에서 사용하는 것과 동일한 데이터 베이스인 Firebase를 사용하고 있습니다. 여러분들의 개인정보는 저희 Firebase 서버에 저장되며, Firebase를 운영하는 Google의 보안 시스템의 보호를 받습니다.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "개인정보 처리 방침",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "회원 탈퇴 즉시 여러분들의 개인정보가 서버에서 제거되며, 소송과 같은 불미스러운 사건에 휘말리지 않는 한 여러분들의 개인정보는 개인정보 보호 법에 의거하여 철저하게 보호 받습니다.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
