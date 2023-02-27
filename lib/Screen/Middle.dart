import 'package:everynue/Popular/Popular_Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../경인교대/Controller.dart';
import 'View_Collecton.dart';


class Middle extends StatefulWidget {
  const Middle({Key? key}) : super(key: key);

  @override
  State<Middle> createState() => _MiddleState();
}

class _MiddleState extends State<Middle> {
  bool scroll = true;
  PageController controller1 = PageController(viewportFraction: 0.8);
  PageController controller2 = PageController(viewportFraction: 0.9);
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 400,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 200,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  image: DecorationImage(
                      image: scroll
                          ? AssetImage("asset/img/통합게시판.jpg")
                          : AssetImage("asset/img/임용고시게시판.jpg"),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ENUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "logo"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: 350,
                  height: 220,
                  child: PageView(
                    controller: controller2,
                    onPageChanged: (index) {
                      setState(() {
                        scroll = !scroll;
                      });
                    },
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Container(
                            height: 230,
                            width: 350.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage("asset/img/통합게시판.jpg"),
                                  fit: BoxFit.fill),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 9,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "통합 게시판",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(1),
                                          fontSize: 30,
                                          fontFamily: "main"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 110,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "통합 임용고시 게시판",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(1),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white.withOpacity(0.9),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: 230,
                                width: 350.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("asset/img/임용고시게시판.jpg"),
                                      fit: BoxFit.fill),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "임용고시 게시판",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontSize: 30,
                                              fontFamily: "main"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 420,
            child: GetBuilder<Controller>(builder: (controller) {
              return PageView(
                controller: controller1,
                children:
                  EducationUniversity.values.toList().map((e) =>
                      CreatePageWidget(context, e, e.index)).toList()
              );
            }),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "POPULAR",
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 30,
              fontFamily: "logo",
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 3.0,
                  color: Colors.blueAccent,
                ),
                Shadow(
                  offset: Offset(10.0, 10.0),
                  blurRadius: 8.0,
                  color: Colors.grey[100]!,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 440,
            child: Popular_Home(),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
