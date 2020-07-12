import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class TodayMenu extends StatefulWidget {
  @override
  _TodayMenuState createState() => _TodayMenuState();
}

class _TodayMenuState extends State<TodayMenu> {
  List<String> _selectList = [];
  List<String> _title = ['당신의 기분은 어떤가요?', '당신의 최애 음식은?', '오늘의 날씨는?'];
  List<String> _feelList = ['기쁨,즐거움', '슬픔', '우울해', '외로움'];
  List<String> _foodLsit = ['한식', '중식', '양식', '분식'];
  List<String> _weatherList = ['흐림', '비', '눈', '맑음'];
  List<Color> _myColors = [
    Colors.redAccent,
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.cyanAccent
  ];
  List<Color> _myColors2 = [
    Color.fromRGBO(179, 66, 245, 1),
    Color.fromRGBO(66, 245, 135, 1),
    Color.fromRGBO(245, 164, 66, 1),
    Color.fromRGBO(245, 72, 66, 1),
  ];

  AnimatorKey animatorKey_1 = AnimatorKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myColors = _myColors.toList()..shuffle();
    _myColors2 = _myColors2.toList()..shuffle();
    print(_myColors);
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('추천메뉴'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Animator(
              animatorKey: animatorKey_1,
              builder: (context, animatorState, child) => Positioned(
                left: animatorState.value * 1.0,
                top: 0.0,
                child: Container(
                  width: _w * 3,
                  height: _h,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: _h,
                        width: _w,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              width: _w,
                              height: _h * 0.1,
                              child: Text(
                                '${_title[0]}',
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                            Container(
                              height: _h * 0.7,
                              alignment: Alignment(0.0, 0.0),
                              margin: EdgeInsets.only(
                                  top: 5.0, left: 10.0, right: 10.0),
                              child: ListView.builder(
                                itemCount: _feelList.length,
                                itemBuilder: (context, index) => Container(
                                    alignment: Alignment(0.0, 0.0),
                                    height: _h * 0.168,
                                    margin: EdgeInsets.only(
                                        top: 5.0, left: 5.0, right: 5.0),
                                    decoration: BoxDecoration(
                                      color: _myColors[index],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(35.0),
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(5.0)),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        '${_feelList[index]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      onTap: () {
                                        if (_selectList.length == 0) {
                                          _selectList.add(_feelList[index]);
                                          animatorKey_1.triggerAnimation();
                                          animatorKey_1.controller.stop();
                                          animatorKey_1.refreshAnimation(
                                              duration: Duration(seconds: 1),
                                              curve: Curves.easeInOut,
                                              tween: Tween(
                                                  begin: 0, end: _w * -1));
                                        }
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: _h,
                        width: _w,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              width: _w,
                              height: _h * 0.1,
                              child: Text(
                                '${_title[1]}',
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                            Container(
                              height: _h * 0.7,
                              alignment: Alignment(0.0, 0.0),
                              margin: EdgeInsets.only(
                                  top: 5.0, left: 10.0, right: 10.0),
                              child: ListView.builder(
                                itemCount: _foodLsit.length,
                                itemBuilder: (context, index) => Container(
                                    alignment: Alignment(0.0, 0.0),
                                    height: _h * 0.168,
                                    margin: EdgeInsets.only(
                                        top: 5.0, left: 5.0, right: 5.0),
                                    decoration: BoxDecoration(
                                      color: _myColors2[index],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(35.0),
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(5.0)),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        '${_foodLsit[index]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      onTap: () {
                                        print(animatorState.value);
                                        if (_selectList.length == 1) {
                                          _selectList.add(_foodLsit[index]);
                                          animatorKey_1.triggerAnimation();
                                          animatorKey_1.controller.stop();
                                          animatorKey_1.refreshAnimation(
                                              duration: Duration(seconds: 1),
                                              curve: Curves.easeInOut,
                                              tween: Tween(
                                                  begin: _w * -1,
                                                  end: _w * -2));
                                        }
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: _h,
                        width: _w,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(0.0, 0.0),
                              width: _w,
                              height: _h * 0.1,
                              child: Text(
                                '${_title[2]}',
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                            Container(
                              height: _h * 0.7,
                              alignment: Alignment(0.0, 0.0),
                              margin: EdgeInsets.only(
                                  top: 5.0, left: 10.0, right: 10.0),
                              child: ListView.builder(
                                itemCount: _weatherList.length,
                                itemBuilder: (context, index) => Container(
                                    alignment: Alignment(0.0, 0.0),
                                    height: _h * 0.168,
                                    margin: EdgeInsets.only(
                                        top: 5.0, left: 5.0, right: 5.0),
                                    decoration: BoxDecoration(
                                      color: _myColors[index],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5.0),
                                          bottomRight: Radius.circular(35.0),
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(5.0)),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        '${_weatherList[index]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      onTap: () {
                                        if (_selectList.length == 2) {
                                          _selectList.add(_weatherList[index]);
                                        }
                                        print(_selectList);
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
