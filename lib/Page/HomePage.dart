import 'package:everynue/Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return HomeScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("본인 이메일 인증"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "완벽한 보안을 위해 마지막으로",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "본인 명의 이메일 인증을 진행하겠습니다!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.deepPurple[200],
                child: Text("본인 이메일 인증하기"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
