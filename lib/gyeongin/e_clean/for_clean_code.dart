import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///NewPosting
class ForNewPosting {
  BuildContext context;

  ForNewPosting({required this.context}) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height - 50;
  }

  ///업로드 함수
  void uploadPosting(String postText) {
    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc("${postText} ${selectedDay}")
        .set({
      "postBody": postText,
      "postTime": selectedDay.toString(),
      "postAuthor": currentUser,
      "postComment": 0,
      "postLike": 0,
      "participants": 0,
      "postView": 0,
      "university": "경인교대",
    });

    Navigator.pop(context);
  }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );
  final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 20);
  final BoxDecoration boxDecoration = BoxDecoration(
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
  );
  final currentUser = FirebaseAuth.instance.currentUser!.email.toString();
  final EdgeInsetsGeometry margin = const EdgeInsets.all(8);
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 30);
  double? width;
  double? height;
}

///NewComment
class ForNewComment {
  BuildContext context;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;

  ForNewComment(
      {required this.context,
      required this.postDocs,
      required this.postIndex}) {
    width = MediaQuery.of(context).size.width;
    viewInsets =
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);
  }

  ///업로드 함수
  void uploadComment(String bodyText, TextEditingController commentController) {
    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc(
            "${postDocs[postIndex]["postBody"]} ${postDocs[postIndex]["postTime"]}")
        .update({"postComment": FieldValue.increment(1)});

    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc(
            "${postDocs[postIndex]["postBody"]} ${postDocs[postIndex]["postTime"]}")
        .collection("경인교대(댓글)")
        .doc("${selectedDay}")
        .set({
      "commentBody": bodyText,
      //댓글의 본문을 추가함
      "commentTime": selectedDay.toString(),
      //댓글 작성 시간을 추가함
      "commentAuthor": currentUser,
      //작성자의 이메일을 추가함
      "commentLike": 0,
    });

    commentController.clear();
    FocusScope.of(context).unfocus();
  }

  final BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(40));
  final InputDecoration inputDecoration = InputDecoration(
    labelText: "댓글을 입력하세요.",
  );
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );
  double? width;
  EdgeInsetsGeometry? viewInsets;

  final EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 5);
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16);
  final currentUser = FirebaseAuth.instance.currentUser!.email.toString();
}

class ForNewReply {
  final BuildContext context;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> postDocs;
  final int postIndex;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs;
  final int commentIndex;

  ForNewReply(
      {required this.postDocs,
      required this.postIndex,
      required this.commentIndex,
      required this.commentDocs,
      required this.context}) {
    width = MediaQuery.of(context).size.width;
  }

  void uploadReply(String replyText, TextEditingController replyController,
      BuildContext context) {
    FirebaseFirestore.instance
        .collection("경인교대(게시글)")
        .doc(
            "${postDocs[postIndex]["postBody"]} ${postDocs[postIndex]["postTime"]}")
        .update({"comment": FieldValue.increment(1)});

    FirebaseFirestore.instance
        .collection("경인교대(게시글)") //게시글 컬렉션의
        .doc(
            "${postDocs[postIndex]["postBody"]} ${postDocs[postIndex]["postTime"]}") // 게시글의 본문과 게시글의 작성 시간을 이름으로 하는 다큐먼트의
        .collection("경인교대(댓글)") // 하위 컬렉션인 댓글 컬렉션의
        .doc(
            "${commentDocs[commentIndex]["commentTime"]}") // 댓글의 작성 시간을 이름으로 하는 다큐먼트의
        .collection("경인교대(답글)") //하위 컬레션인 답글 컬렉션에
        .doc("${selectedDay}") // 답글 작성 시간을 이름으로 하는 다큐먼트를 생성
        .set({
      "replyBody": replyText,
      "replyTime": selectedDay.toString(),
      "replyAuthor": currentUser,
      "replyLike": 0,
    });
    replyController.clear();
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour + 9,
    DateTime.now().minute,
    DateTime.now().second,
    DateTime.now().millisecond,
  );

  final currentUser = FirebaseAuth.instance.currentUser!.email.toString();
  double? width;
  EdgeInsetsGeometry? viewInsets;
  final BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.grey[200], borderRadius: BorderRadius.circular(20));
  final EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 5);
  final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16);
}
