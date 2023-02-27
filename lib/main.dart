
import 'package:flutter/material.dart';
import 'package:everynue/Page/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'drift/drift_database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting();

  final database = LocalDatabase(); //클래스 인스턴스 생성

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MainPage(),
    ),
  );
}
