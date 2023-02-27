import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GINUE_NewPosting extends StatefulWidget {
  GINUE_NewPosting({Key? key}) : super(key: key);

  @override
  State<GINUE_NewPosting> createState() => _GINUE_NewPostingState();
}

class _GINUE_NewPostingState extends State<GINUE_NewPosting> {

  bool image_selected = false;

  String mytoken = "";
  String imageUrl = "";
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );
  final _Body_contorller = TextEditingController();
  var _Body_Context = "";

  getToken() async {
    //토큰 받아오기
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(
          () {
            mytoken = token!;
          },
        );
      },
    );
  }

  void _sendMessage() async {
    await getToken(); //토큰을 먼저 받아오고, mytoken에 저장한 다음 바뀐 mytoken을 set해야해서 먼저 선언

    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc("${_Body_Context} ${selectedDay}")
        .set({
      "body": _Body_Context,
      "time": selectedDay.toString(),
      "userID": FirebaseAuth.instance.currentUser!.email.toString(),
      "comment": 0,
      "like": 0,
      "view": 0,
      "order": 0,
      "image": imageUrl,
      "university": "경인교대",
      "토큰": mytoken
    });

    Navigator.pop(context);
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImageFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 25,
              child: Center(
                child: Text("사진이 선택되었습니다."),
              ),
            ),
          );
        },
      );
      setState(() {
        image_selected = true;
      });
    }


    if (pickedImageFile == null)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 25,
              child: Center(
                child: Text("사진이 선택되지 않았습니다."),
              ),
            ),
          );
        },
      );

    Reference referenceRoot = FirebaseStorage.instance.ref(); //스토리지를 사용할건데

    Reference referenceDirImages = referenceRoot.child("images"); //image 폴더에

    Reference referenceImageToUpload = referenceDirImages.child(
        "${FirebaseAuth.instance.currentUser!.email.toString()} ${selectedDay}"); //유저이름 + 현재 시간으로 이미지 이름을 저장할거야

    try {
      await referenceImageToUpload.putFile(
          File(pickedImageFile!.path)); //그리고 그 이미지의 url을 가져와서 imageUrl 변수에 넣을게
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 50,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 2000,
                controller: _Body_contorller,
                decoration: InputDecoration(
                  labelText: "7자 이상 입력",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _Body_Context = value;
                  });
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 120,
            child: Text(
              'EVERYNUE는 타인의 권리를 침해하거나, 반 사회적인 사상이 담긴 글은 존중하지 않습니다. EVERYNUE는 그 어떤 경우에도 여러분들의 익명성과 개인정보를 최우선으로 보호할 것입니다. 하지만, 이를 악용하여 발생하는 문제에 대한 책임은 본인에게 있습니다.',
              style: TextStyle(color: Colors.grey),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  color: image_selected == true? Colors.blueAccent: Colors.grey,
                  onPressed: () {
                    pickImage();
                  },
                  icon: Icon(Icons.image)),
              SizedBox(
                width: 50,
              ),
              IconButton(
                  color: Colors.red[400],
                  onPressed:
                      _Body_Context.trim().length < 7 ? null : _sendMessage,
                  icon: Icon(Icons.send)),
            ],
          ),
        ],
      ),
    );
  }
}
