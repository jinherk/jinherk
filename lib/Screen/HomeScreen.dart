import 'package:everynue/%EA%B2%BD%EC%9D%B8%EA%B5%90%EB%8C%80/GINUE_Posting/GINUE_Posting_Form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../timetable/timetable_home.dart';
import '../경인교대/Controller.dart';
import 'More/More.dart';
import '../Chatting/Chat_Home.dart';
import 'package:flutter/material.dart';
import 'package:everynue/Screen/Index0.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Controller controller = Get.put(Controller()); //상태관리 프로바이더

  int selectedindex = 0; //바텀 네비게이션 바의 선택된 인덱스가 여기에 담김
  List<Widget> indexlist = [
    index0(),
    TimeTableHome(),
    Chat_Home(),
    More()
  ]; //바텀 네비게이션 바 각 인덱스에 대응되는 위젯들 리스트

  void requestPermission() async {
    //권한 요청 보내기
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );
  }

  @override
  void didChangeDependencies() {
    controller.getData(); //앱 시작과 동시에 바로 getData로 학교 읽어옴
    super.didChangeDependencies();
  }
  @override
  void initState() {

    requestPermission(); //권한 요청 보내기

    var channel = const AndroidNotificationChannel(
      'EVERYNUE', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: false,
    );

    var flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin(); //패키지 불러오기

    flutterLocalNotificationsPlugin //채널 생성
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher'); //안드로이드에서 알림에 사용할 아이콘을 지정함

    var initializationSettings = InitializationSettings(
      android: androidSetting,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        var data = message.data;
        String? Body = data["Body"];
        String? time = data["time"];
        String? author = data["author"];
        String? mother_comment = data["mother_comment"];
        String? order = data["order"];
        String? mother_like = data["mother_like"];
        String? imageurl = data["imageurl"];
        String? university = data["university"];
        String? token = data["token"];
        String? type = data["type"];
        String? mytoken = data["mytoken"];

        void onDidReceiveNotificationResponse(  //알림을 누르면 실행할 함수
            NotificationResponse notificationResponse) async {
          final String? payload = notificationResponse.payload;
          if (notificationResponse.payload != null) {
            debugPrint('notification payload: $payload');
          }
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (context) => GINUE_details(
                      body: Body!,
                      time: time!,
                      author: author!,
                      mother_comment: int.parse(mother_comment!),
                      order: int.parse(order!),
                      imageurl: imageurl!,
                      university: university!,
                      mother_like: int.parse(mother_like!),
                      token: token!,
                      mytoken: mytoken!,
                    )),
          );
        }

        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

        if (type == null) {
          flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }

        if (type != null) {
          final snackBar = SnackBar(
            content: Text("${message.notification?.body}"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var data = message.data;
      String? Body = data["Body"];
      String? time = data["time"];
      String? author = data["author"];
      String? mother_comment = data["mother_comment"];
      String? order = data["order"];
      String? mother_like = data["mother_like"];
      String? imageurl = data["imageurl"];
      String? university = data["university"];
      String? token = data["token"];
      String? type = data["type"];
      String? mytoken = data["mytoken"];

      if (type == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return GINUE_details(
                body: Body!,
                time: time!,
                author: author!,
                mother_comment: int.parse(mother_comment!),
                order: int.parse(order!),
                imageurl: imageurl!,
                university: university!,
                mother_like: int.parse(mother_like!),
                token: token!,
                mytoken: mytoken!,
              );
            },
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width - 20,
          height: 60,
          child: GNav(
              tabBorderRadius: 20,
              curve: Curves.easeIn,
              color: Colors.blueAccent[100],
              gap: 8,
              activeColor: Colors.white,
              iconSize: 34,
              tabBackgroundColor: Colors.red.withOpacity(0.8),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onTabChange: (index) {
                setState(() {
                  selectedindex = index;
                });
              },
              // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: '홈',
                ),
                GButton(
                  icon: Icons.calendar_today,
                  text: '시간표',
                ),
                GButton(
                  icon: Icons.chat_bubble,
                  text: '채팅',
                ),
                GButton(
                  icon: Icons.menu,
                  text: '설정',
                ),
              ]),
        ),
        backgroundColor: Colors.white,
        body: indexlist[selectedindex]);
  }
}
