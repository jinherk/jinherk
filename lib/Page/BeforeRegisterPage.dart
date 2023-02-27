import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'RegisterPage.dart';

class BeforeRegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const BeforeRegisterPage({required this.showLoginPage, Key? key})
      : super(key: key);

  @override
  State<BeforeRegisterPage> createState() => _BeforeRegisterPageState();
}

class _BeforeRegisterPageState extends State<BeforeRegisterPage> {
  String name = "";
  String number = "";

  bool nameConfirm = false;
  bool numberConfirm = false;

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  void gonextpage() {
    name = _nameController.text;
    number = _numberController.text;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return RegisterPage(
            showLoginPage: widget.showLoginPage, name: name, number: number);
      }),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();

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
                          keyboardType: TextInputType.name,
                          controller: _nameController,
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
                            hintText: "이름을 입력해주세요!",
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
                          keyboardType: TextInputType.name,
                          controller: _numberController,
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
                            hintText: "학번을 입력해주세요!(숫자만)",
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            gonextpage();
                          },
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
                                "다음",
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
