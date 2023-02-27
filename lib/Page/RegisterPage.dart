import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  final String name;
  final String number;
  const RegisterPage({
    required this.showLoginPage,
    Key? key,
    required this.name,
    required this.number,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String fakeuniversity = "";
  String realuniversity = "";

  bool emailConfirm = false;
  bool universityConfirm = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  Future Signup() async {
    emailConfirmed();
    if (passwordConfirmed() &&
        emailConfirm == true &&
        universityConfirm == true) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      addUserDetails(realuniversity);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("교육대학교 이메일이 아니거나, 비밀번호가 동일하지 않습니다."),
            );
          });
    }
  }

  Future addUserDetails(university) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set({
      "이름": widget.name,
      "학번": widget.number,
      "학교": realuniversity,
      "id": FirebaseAuth.instance.currentUser!.email.toString()
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
            _confirmpasswordController.text.trim() &&
        emailConfirm == true) {
      return true;
    } else {
      return false;
    }
  }

  String extractEmailProvider(String email) {
    RegExp emailPattern = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (emailPattern.hasMatch(email)) {
      List<String> parts = email.split('@');
      return parts[1].split('.')[0];
    } else {
      return 'Invalid email';
    }
  }

  Map<String, String> UniversityMaker = {
    "knue": "한국교원대학교 초등교육과",
    "ginue": "경인교육대학교",
    "gjue": "공주교육대학교",
    "gnue": "광주교육대학교",
    "dnue": "대구교육대학교",
    "bnue": "부산교육대학교",
    "snue": "서울교육대학교",
    "jj": "전주교육대학교",
    "cue": "진주교육대학교",
    "cje": "청주교육대학교",
    "cnue": "춘천교육대학교",
    "jejunu": "제주대학교 초등교육과",
    "ewhain": "이화여자대학교 초등교육과"
  };

  List<String> acceptableInputs = [
    "knue",
    "ginue",
    "gjue",
    "gnue",
    "dnue",
    "bnue",
    "snue",
    "jj",
    "cue",
    "cje",
    "cnue",
    "jejunu",
    "ewhain"
  ];

  emailConfirmed() {
    email = _emailController.text;
    String fakeuniversity = extractEmailProvider(email);
    if (acceptableInputs.contains(fakeuniversity) == false) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("교육대학교 이메일이 아니거나, 비밀번호가 동일하지 않습니다."),
            );
          });
    } else {
      try {
        if (acceptableInputs.contains(fakeuniversity)) {
          setState(() {
            universityConfirm = true;
            emailConfirm = true;
          });
        } else {
          setState(() {
            universityConfirm = false;
            emailConfirm = false;
          });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    emailConfirm == false ? "교육대학교 학생이 아닙니다." : "확인되었습니다."),
              );
            });
      }
      realuniversity = UniversityMaker[fakeuniversity]!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  LottieBuilder.asset("asset/lotties/register_animation.json"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "환영합니다!",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "아래 양식을 따라주세요.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent[200]!),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "교육대학교 이메일을 입력해주세요!",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueAccent[200]!),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "비밀번호",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: _confirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.deepPurple[400]!),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "비밀번호 확인",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: Signup,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.blueAccent[200]!,
                                    Colors.pinkAccent[100]!,
                                    const Color(0xFFF27121),
                                  ]),
                            ),
                            child: const Center(
                              child: Text(
                                "회원 가입",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "회원이신가요?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.showLoginPage,
                            child: Text(
                              "   로그인 하러가기",
                              style: TextStyle(
                                color: Colors.blueAccent[200],
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
