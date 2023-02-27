import 'package:everynue/Page/AuthPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage(); //로그인,회원가입을 완료하면 이동하는 페이지
          } else {
            return const AuthPage(); //첫 페이지 (이미 한번 로그인했으면 바로 HomePage()로 이동함)
          }
        },
      ),
    );
  }
}
