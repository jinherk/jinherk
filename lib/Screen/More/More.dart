import 'package:everynue/Page/ForgotPasswordPage.dart';
import 'package:everynue/Screen/More/Private.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/img/More.jpg"), fit: BoxFit.fill),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${FirebaseAuth.instance.currentUser!.email.toString()}",
                      style: TextStyle(fontSize: 20, fontFamily: "logo"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 230,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[300]!),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "계정",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }),
                        );
                      },
                      child: Text(
                        "비밀번호 변경",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        "로그아웃",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: GestureDetector(
                                  onTap: (){
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    height: 80,
                                    child: Column(
                                      children: [
                                        Text(
                                          "정말로 탈퇴하시겠습니까?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            FirebaseAuth.instance.currentUser!.delete();
                                          },
                                          child: Text(
                                            "예",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "회원탈퇴",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[300]!),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "기타 이용 안내",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Private()));
                      },
                      child: Text(
                        "개인정보 처리방침",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "앱 버전",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "1.0",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Text(
                                        "jinherk123@naver.com",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "편하게 문의해주세요!",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "문의하기",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  width: 220,
                                  height: 350,
                                  child: Column(
                                    children: [
                                      Text(
                                        "cupertino_icons: ^1.0.2",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "cloud_firestore: ^4.3.1",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "cloud_firestore: ^4.3.1",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "firebase_auth: ^4.2.5",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "firebase_core: ^2.5.0",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "shared_preferences: ^2.0.17",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "lottie: ^2.2.0",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "google_nav_bar: ^5.0.6",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "firebase_storage: ^11.0.10",
                                        textAlign: TextAlign.center,
                                      ),Text(
                                        "image_picker: ^0.8.6+1",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "firebase_messaging: ^14.2.2",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "flutter_local_notifications: ^13.0.0",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "http: ^0.13.5",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "flaticon author(comment): Karacis",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "flaticon author(heart): aslaiart",
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "flaticon author(cat): AomAm",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        "오픈소스 및 UI 라이선스",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
