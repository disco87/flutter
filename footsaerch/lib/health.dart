import 'package:flutter/material.dart';

import 'helthweb.dart';

class MyHealth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              HealthMenu(
                leftScale: 0.18,
                leftColor: Color.fromRGBO(15, 40, 122, 1),
                leftIcon: Image.asset(
                  'assets/images/h1.png',
                  fit: BoxFit.cover,
                ),
                leftLabel: Text(
                  '스쿼트',
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(15, 40, 122, 1)),
                ),
                leftOnPress: () => Navigator.pushNamed(context, '/healthWeb',
                    arguments: MyWebArgs('스쿼트',
                        'https://m.post.naver.com/viewer/postView.nhn?volumeNo=28549529&memberNo=24635978&vType=VERTICAL')),
                //오른쪽-----------------------
                rightScale: 0.235,
                rightColor: Color.fromRGBO(44, 142, 212, 1),
                rightIcon: Image.asset(
                  'assets/images/h2.png',
                  fit: BoxFit.cover,
                ),
                rightLabel: Text(
                  '런 지',
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(15, 40, 122, 1)),
                ),
                rightOnPress: () => print('런 지'),
              ),
              //-----------------2번 메뉴
              HealthMenu(
                leftScale: 0.18,
                leftColor: Color.fromRGBO(208, 101, 224, 1),
                leftIcon: Image.asset(
                  'assets/images/h3.png',
                  fit: BoxFit.cover,
                ),
                leftLabel: Text(
                  '플랭그',
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(208, 101, 224, 1)),
                ),
                leftOnPress: () => print('플랭그'),
                //오른쪽-----------------------107, 9, 122, 0.9
                rightScale: 0.08,
                rightColor: Color.fromRGBO(107, 9, 122, 0.9),
                rightIcon: Image.asset(
                  'assets/images/h4.png',
                  fit: BoxFit.cover,
                ),
                rightLabel: Text(
                  '점프스쿼트',
                  style: TextStyle(
                      fontSize: 20.0, color: Color.fromRGBO(107, 9, 122, 0.9)),
                ),
                rightOnPress: () => print('점프스쿼트'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthMenu extends StatelessWidget {
  Widget leftIcon, rightIcon, leftLabel, rightLabel;
  var leftOnPress, rightOnPress;
  Color leftColor, rightColor;
  double leftScale, rightScale;
  HealthMenu(
      {this.leftIcon,
      this.rightIcon,
      this.leftLabel,
      this.rightLabel,
      this.leftOnPress,
      this.rightScale,
      this.leftScale,
      this.leftColor,
      this.rightColor,
      this.rightOnPress});
  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Container(
          height: _h * 0.2,
          width: _w * 0.35,
          margin: EdgeInsets.fromLTRB(_w * 0.1, 20.0, _w * 0.05, 0.0),
          decoration: BoxDecoration(),
          child: LayoutBuilder(
            builder: (context, constraints) => FlatButton(
              // color: leftColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: leftColor, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(35)),
              onPressed: leftOnPress,
              child: Container(
                height: _h * 0.2,
                width: _w * 0.35,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: leftIcon,
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.73,
                      left: constraints.minWidth * leftScale,
                      child: Container(
                        // alignment: Alignment(0.0, 0.0),
                        child: leftLabel,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _h * 0.2,
          width: _w * 0.35,
          margin: EdgeInsets.fromLTRB(_w * 0.05, 20.0, 0.0, 0.0),
          decoration: BoxDecoration(),
          child: LayoutBuilder(
            builder: (context, constraints) => FlatButton(
              // color: rightColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: rightColor, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(35)),
              onPressed: rightOnPress,
              child: Container(
                height: _h * 0.2,
                width: _w * 0.35,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: rightIcon,
                    ),
                    Positioned(
                      left: constraints.maxWidth * rightScale,
                      top: constraints.minHeight * 0.73,
                      child: Container(
                        width: constraints.maxWidth,
                        // alignment: Alignment(0.0, 0.0),
                        child: rightLabel,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
