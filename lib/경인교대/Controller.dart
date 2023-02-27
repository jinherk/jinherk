import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {


  String school = "";


  final DocumentReference userDocument = FirebaseFirestore.instance
      .collection('users').doc(
      "${FirebaseAuth.instance.currentUser!.email.toString()}");

  void getData() {
    userDocument.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data()! as Map<String, dynamic>;
        school = "${data["학교"]}";
        update();
      } else {
        print('Document does not exist on the database');
      }
    });
  }

}
