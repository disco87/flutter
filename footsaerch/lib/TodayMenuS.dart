import 'package:flutter/material.dart';

class MenuPick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Pick'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(_w * 0.05, _h * 0.05, _w * 0.05, _h * 0.05),
        child: Column(
          children: <Widget>[
            Container(
              child: Text('aaa'),
            ),
            Container(
              child: ListTile(
                leading: Image.asset('assets/images/r1.jpg'),
                title: Text('Roulette'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
