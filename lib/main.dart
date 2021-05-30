// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:swl_teaming/screens/MainPage.dart';
import 'package:swl_teaming/screens/PersonalCalendar.dart';
import 'package:swl_teaming/screens/map.dart';
import 'package:swl_teaming/screens/showArticle.dart';
import 'package:swl_teaming/screens/themeSetting.dart';
import 'package:swl_teaming/screens/SignUp.dart';
import 'package:swl_teaming/screens/loginPage.dart';
import 'package:swl_teaming/screens/createArticle.dart';
import 'package:swl_teaming/screens/loadingPage.dart';
import 'package:swl_teaming/screens/Drawer.dart';

void main() async {
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
        fontFamily: 'SLEIGothic',
        appBarTheme: AppBarTheme(
          color: Color(0xFFFFFFFF),
          iconTheme: IconThemeData(color: Color(0xFF283593)),
        ),
        primaryColor: Color(0xFF9FA8DA),
        primaryColorDark: Color(0xFF283593),
        primaryColorLight: Colors.indigo[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/mainPage': (context) => MainPage(),
        '/calendar': (context) => PersonalCalendar(),
        '/themeSetting': (context) => themeSetting(),
        '/map': (context) => mapPage(),
        '/createarticle': (context) => CreateArticle(),
        '/loading': (context) => LoadingScreen(),
        '/showarticle': (context) => ShowArticle(),
        '/drawer': (context) => DrawerPage()
      },
    );
  }
}
