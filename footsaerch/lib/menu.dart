import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

//메뉴구성 - 1.오늘의 요리 추천 2.냉장고를털어라 3.메뉴 룰렛
class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    double _scale = _w * 0.0071;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 20,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  '가장 맛있는 요리',
                  style: TextStyle(
                      fontSize: 40.0, color: Colors.grey.withOpacity(0.5)),
                ),
              )),
          Positioned(
              top: 30,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.16,
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  'Food Cook',
                  style: TextStyle(
                      fontSize: 45.0, color: Color.fromRGBO(8, 40, 71, 0.8)),
                ),
              )),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              child: ClipPath(
                clipper: MenuBackground(),
                child: Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromARGB(255, 196, 209, 8),
                ),
              ),
            ),
          ),
          CircleButton(
            top: _h * 0.68,
            left: _w * 0.38,
            scale: _scale,
            colors: Colors.grey,
            image: DecorationImage(
                image: AssetImage('assets/images/foodSearch.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45), BlendMode.dstATop)),
            child: Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Text(
                  '나의 레시피',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white
                          .withOpacity(1), //Color.fromRGBO(8, 40, 71, 0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
              ],
            ),
            onPressed: () {
              print(4);
              // Navigator.pop(context);
            },
          ),
          CircleButton(
            top: _h * 0.5,
            left: _w * 0.05,
            scale: _scale,
            colors: Colors.white,
            child: Text(
              'Health',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(14, 44, 71, 0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            onPressed: () {
              print('3');
              Navigator.pushNamed(context, '/myhealty');
            },
          ),
          CircleButton(
            top: _h * 0.34,
            left: _w * 0.38,
            scale: _scale,
            colors: Colors.grey,
            image: DecorationImage(
                image: AssetImage('assets/images/foods.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45), BlendMode.dstATop)),
            child: Text(
              '냉장고를 털어라',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/first');
              print(2);
            },
          ),
          CircleButton(
            top: _h * 0.165,
            left: _w * 0.05,
            scale: _scale,
            colors: Colors.white,
            child: Text(
              'Menu Pick',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(14, 44, 71, 0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            onPressed: () {
              print('1');
              Navigator.pushNamed(context, '/menupick');
            },
          ),
        ],
      ),
    );
  }
}

class MenuBackground extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 4);
    path.quadraticBezierTo(
        95, size.height / 4 * 2, 0, size.height / 4 * 3 + 40);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CircleButton extends StatelessWidget {
  double top;
  double left;
  double scale;
  Color colors;
  Widget child;
  DecorationImage image;
  var onPressed;

  CircleButton(
      {this.colors,
      this.left,
      this.top,
      this.scale,
      this.onPressed,
      this.child,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment(0.0, 0.03),
          decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.all(Radius.circular(200)),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1.3)],
              image: image),
          width: MediaQuery.of(context).size.width / 5 * scale,
          height: MediaQuery.of(context).size.width / 5 * scale,
          child: child,
        ),
      ),
    );
  }
}
