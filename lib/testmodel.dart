
import 'package:cloud_firestore/cloud_firestore.dart';

class testmodel {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocs ;
  int chatDocsIndex;

  testmodel({required this.chatDocs, required this.chatDocsIndex});

  late String body = chatDocs[chatDocsIndex]["body"];


}