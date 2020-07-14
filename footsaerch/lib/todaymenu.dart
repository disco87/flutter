import 'package:flutter/material.dart';

class TodayMenuR extends StatefulWidget {
  @override
  _TodayMenuRState createState() => _TodayMenuRState();
}

class _TodayMenuRState extends State<TodayMenuR>
    with SingleTickerProviderStateMixin {
  List<String> _bunsic = ['김밥', '오므라이스', '떡볶이', '쫄면', '오뎅', '튀김'];
  AnimationController _controller;
  Animation _animation;
  bool isSelect = false;
  List<Color> myColor = [
    Color.fromRGBO(252, 169, 3, 1.0),
    Color.fromRGBO(232, 2, 44, 1.0)
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: _bunsic.length * 100));
    _animation = Tween<double>(begin: 1, end: _bunsic.length.toDouble())
        .animate(_controller)
          ..addStatusListener((status) {
            //Status를 통해 애니메이션 반복
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });

    _controller.forward(); //애니메이션 스타트
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Roulette',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: AnimatedBuilder(
        animation:
            _animation, //_animation에 _controllr가 전달 되었으므로 _animation 변수를 사용
        builder: (context, child) => Center(
          child: Stack(children: <Widget>[
            Positioned(
              top: _h * 0.05,
              left: _w * 0.075,
              child: Container(
                width: _w * 0.85,
                height: _h * 0.5,
                padding: EdgeInsets.fromLTRB(22, 22, 22, 45),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                      width: 3.5, color: isSelect ? myColor[1] : myColor[0]),
                ),
                child: Image.asset(
                  'assets/images/bunsic/${(_animation.value ~/ 1)}.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                top: _h * 0.55 - 25.0,
                left: _w * 0.5 - 80.0,
                child: Container(
                    height: 50.0,
                    width: 160.0,
                    alignment: Alignment(0.0, 0.0),
                    // color: Colors.blueAccent,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromRGBO(3, 0, 74, 1), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Text(
                      '${_bunsic[_animation.value ~/ 1 - 1]}',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ))),
            Positioned(
              top: _h * 0.62,
              left: _w * 0.3,
              child: Container(
                width: _w * 0.4,
                height: _w * 0.4,
                color: Colors.transparent,
                child: RaisedButton(
                  child: Text(isSelect ? 'START' : 'STOP',
                      style: TextStyle(
                          color: isSelect ? myColor[0] : myColor[1],
                          fontSize: 35.0)),
                  color: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_w * 0.2),
                      side: BorderSide(
                          color: isSelect ? myColor[0] : myColor[1], width: 2)),
                  onPressed: () {
                    setState(() {
                      isSelect = !isSelect;
                      print(isSelect);
                      if (isSelect == false)
                        _controller.fling(); //애니메이션 재시작
                      else if (isSelect == true) _controller.stop(); //애니페이션 스톰
                    });
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
