import 'package:flutter/material.dart';
import 'package:footsaerch/MyWebView.dart';
import 'package:footsaerch/firstpage.dart';
import 'package:footsaerch/helthweb.dart';
import 'package:footsaerch/menu.dart';
import 'package:footsaerch/todaymenu.dart';
import 'TodayMenuS.dart';
import 'health.dart';

void main() => runApp(MyApp());
//test 해보자
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'cute',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/first': (context) => FirstPage(),
        '/MyWebView': (context) => MyWebView(),
        '/TodayMenu': (context) => TodayMenu(),
        '/myhealty': (context) => MyHealth(),
        '/healthWeb': (context) => HealthWeb(),
        '/TodayMenuR': (context) => TodayMenuR()
      },
    );
  }
}

//https://dev-yakuza.github.io/ko/react-native/android-google-play/
//어플 등록 정보
