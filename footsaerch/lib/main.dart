import 'package:flutter/material.dart';
import 'package:footsaerch/MyWebView.dart';
import 'package:footsaerch/firstpage.dart';
import 'package:footsaerch/helthweb.dart';
import 'package:footsaerch/menu.dart';
import 'package:footsaerch/todaymenu.dart';
import 'TodayMenuS.dart';
import 'health.dart';

//https://clein8.tistory.com/entry/Flutter-%EC%95%B1%EC%97%90-Firebase-%EC%B6%94%EA%B0%80
//https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter/index.html#3
void main() => runApp(MyApp());

//test 해보자P
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '냉장고를 털어라',
      theme: ThemeData(
        fontFamily: 'cute',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/first': (context) => FirstPage(),
        '/MyWebView': (context) => MyWebView(),
        '/menupick': (context) => MenuPick(),
        '/myhealty': (context) => MyHealth(),
        '/healthWeb': (context) => HealthWeb(),
        '/TodayMenuR': (context) => TodayMenuR()
      },
    );
  }
}

//https://dev-yakuza.github.io/ko/react-native/android-google-play/
//어플 등록 정보
