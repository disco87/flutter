import 'package:flutter/material.dart';

class MenuPick extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Menu Pick'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(_w * 0.05, _h * 0.05, _w * 0.05, _h * 0.05),
        child: Column(
          children: <Widget>[
            MenuButton(
              onTap: () => Navigator.pushNamed(context, '/TodayMenuR'),
              // image: Image.asset(
              //   'assets/images/roullette.jpg',
              //   fit: BoxFit.fill,
              // ),
              title: 'Roullet',
              color: Colors.indigoAccent,
            ),
            MenuButton(
              onTap: () =>
                  showSnackBar(), //Navigator.pushNamed(context, '/TodayMenuR'),
              // image:
              //     Image.asset('assets/images/roullette.jpg', fit: BoxFit.fill),
              title: '메뉴 추천(준비중)',
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        '서비스 준비 중',
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 1),
    ));
  }
}

class MenuButton extends StatelessWidget {
  var onTap;
  Widget image;
  String title;
  Color color;
  MenuButton({this.image, this.onTap, this.title, this.color});
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _h * 0.35,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment(0.0, 0.0),
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              child: image,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
