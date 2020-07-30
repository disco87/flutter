import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:footsaerch/MyWebView.dart';
import 'package:footsaerch/firstpage.dart';
import 'package:footsaerch/helthweb.dart';
import 'package:footsaerch/menu.dart';
import 'package:footsaerch/screen/myrecipe.dart';
import 'package:footsaerch/todaymenu.dart';
import 'TodayMenuS.dart';
import 'health.dart';
import 'screen/myrecipe.dart';

//https://clein8.tistory.com/entry/Flutter-%EC%95%B1%EC%97%90-Firebase-%EC%B6%94%EA%B0%80
//https://opensupport.tistory.com/entry/Flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%95%88%EB%93%9C%EB%A1%9C%EC%9D%B4%EB%93%9C-iOS-%EA%B5%AC%EA%B8%80-%EC%95%A0%EB%93%9C%EB%AA%B9-%EB%B0%B0%EB%84%88-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-Applying-Android-iOS-Google-AdMob-banner

void main() => runApp(MyApp());

//test 해보자P
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Datepicker를 사용하기 위한 지역 설정
//      localizationsDelegates: [
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale('en','US'),
//        const Locale('ko','KO'),
//      ],
      //----------------------------------
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
        '/TodayMenuR': (context) => TodayMenuR(),
        '/recipe':(_) => MyRecipe(),
      },
    );
  }
}

//https://dev-yakuza.github.io/ko/react-native/android-google-play/
//어플 등록 정보
