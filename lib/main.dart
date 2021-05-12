import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:swl_teaming/screens/MainPage.dart';
import 'package:swl_teaming/screens/PersonalCalendar.dart';
import 'package:swl_teaming/screens/themeSetting.dart';
import 'package:swl_teaming/screens/SignUp.dart';
import 'package:swl_teaming/screens/loginPage.dart';
import 'package:swl_teaming/screens/boardPage.dart';

void main() async{
// void main() {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFFFFFFFF),
          iconTheme: IconThemeData(color: Color(0xFFFC8D78)),
        ),
        primaryColor: Color(0xFFFFB8AC),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/mainPage': (context) => MainPage(),
        '/calendar': (context) => PersonalCalendar(),
        '/themeSetting': (context) => themeSetting(),
        '/board': (context) => BoardPage(),
      },
    );
  }
}
