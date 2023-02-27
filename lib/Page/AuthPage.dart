import 'package:everynue/Page/BeforeRegisterPage.dart';
import 'package:everynue/Page/LoginPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });

  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(showRegisterPage: toggleScreens);  //첫 화면은 로그인 페이지 회원가입 하러가기 누르면 toggleScreens 함수 발동해서 회원가입 페이지로 이동함
    } else {
      return BeforeRegisterPage(showLoginPage: toggleScreens); //로그인 하러가기 누르면 toggleScreens 함수 발동해서 로그인 페이지로 이동함
    }
  }
}
