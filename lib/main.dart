import 'dart:io';
import 'package:chat_app_demo3/screens/calls.dart';
import 'package:chat_app_demo3/screens/chats.dart';
import 'package:chat_app_demo3/screens/home_page.dart';
import 'package:chat_app_demo3/screens/login/edit_number.dart';
import 'package:chat_app_demo3/screens/login/hello.dart';
import 'package:chat_app_demo3/screens/login/select_country.dart';
import 'package:chat_app_demo3/screens/login/verify_number.dart';
import 'package:chat_app_demo3/screens/people.dart';
import 'package:chat_app_demo3/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';

const bool USE_EMULATOR = true;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (USE_EMULATOR) {
    _connectToFirebaseEmulator();
  }

  runApp(const MyApp());
}

Future _connectToFirebaseEmulator() async {
  final fireStorePort = 8080;
  final authPort = 9099;
  final localHost = Platform.isAndroid
      ? '10.0.2.2'
      : 'localHost'; //10.0.2.2 는 안드로이드 고유 IP, 실물 device 쓸거면 그 device IP 필요
  FirebaseFirestore.instance.settings = Settings(
      host: "$localHost:$fireStorePort",
      sslEnabled: false,
      persistenceEnabled: false);

  await FirebaseAuth.instance.useAuthEmulator(localHost, authPort);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Hello(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF08C187),
      ),
    );
  }
}
