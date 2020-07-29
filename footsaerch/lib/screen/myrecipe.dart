import 'package:flutter/material.dart';
import 'package:footsaerch/MyWebView.dart';
import 'package:footsaerch/control/dbhelper.dart';
import 'package:footsaerch/model/foodmodel.dart';
/*
음식을 Search 후 레시피를 저장하는 페이지
 */


class MyRecipe extends StatefulWidget {
  @override
  _MyRecipeState createState() => _MyRecipeState();
}

class _MyRecipeState extends State<MyRecipe> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 레시피'),
      ),
      body: Stack(
          children:<Widget>[ FutureBuilder(
            future: DBHelper().foods(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    FoodModel fd = snapshot.data[index];

                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        DBHelper().deleteFood(fd.id);
                        setState(() {});
                      },
                      child: ListTile(
                        leading: Image.network(
                          fd.imgUrl.toString(),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(fd.title.toString()),
                        subtitle: Text(fd.date.toString()),
                        onTap: () {

                          Navigator.pushNamed(
                            context,
                            '/MyWebView',
                            arguments: MyWebArgs(fd.title, fd.siteUrl, fd.imgUrl, false),
                          );
                        },
                      ),
                    );
                  },
                );
              }else return Center(child: CircularProgressIndicator(),);
            },
          ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
//              top: isSelect?80.0:size.height,
              curve: Curves.easeInOutBack,
              top:80.0,
              left: isSelect?0.0:size.width,
//            opacity: isSelect?1.0 : 0.0,
              child: SizedBox(
                width: size.width,
                height: size.height * 0.6,
                child: CustomPaint(
                  painter: SearchP(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.6,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top:75.0,
                            left: 35.0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isSelect =! isSelect;
                                });
                              },
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Color.fromRGBO(0, 1, 43, 1),
                                  child: Icon(Icons.close,color: Colors.limeAccent,)),
                            )),
                        Positioned(
                          top: 135.0,
                          left: size.width * 0.12,
                          child: Text('S e a r c h',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
//                              decoration: TextDecoration.underline,
                            ),
                          )),
                        Positioned(
                          top: 180.0,
                          left: size.width * 0.2,
                            child: Container(
                              width: 250.0,
                              child: TextField(

                                decoration: InputDecoration(
                                  hintText: '검색어를 입력해하세요.',
                                  icon: Icon(Icons.search),

                                ),
                              ),
                            )),
                        Positioned(
                            bottom: 30.0,
                            left:size.width * 0.5 - 35,
                            child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white,width: 2.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Colors.transparent,
                            elevation: 0.0,
                            child: Text('검 색',style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0
                            ),),
                            onPressed: (){}))
                      ],
                    ),
                  ),

                ),
              ),
            ),
          ]
      ),
      floatingActionButton: isSelect?Container():FloatingActionButton(
        child: Icon(Icons.search),
          onPressed: (){
            setState(() {
              isSelect = !isSelect;
            });
          }),
    );
  }
}




class SearchPainter extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final double myRound = 50.0;

    Path path = Path()
      ..moveTo(35.0, 100.0)
      ..lineTo(size.width - 40  , 50.0)
      ..arcToPoint(Offset(size.width - 15 , 75.0),radius: Radius.circular(25.0))
      ..lineTo(size.width - 45.0, size.height-10.0)
      ..arcToPoint(Offset(size.width - 55, size.height), radius: Radius.circular(10.0))
      ..lineTo(size.width * 0.23 , size.height - 20.0)
      ..arcToPoint(Offset(size.width * 0.23 - 10.0, size.height - 30.0),radius:  Radius.circular(10.0))
      ..lineTo(15.0, 120.0)
      ..arcToPoint(Offset(35.0, 100.0),radius: Radius.circular(20))
      ..close();

//    Paint paint = Paint();
//    paint.color = Colors.red;
//    Canvas canvas;
//    canvas.drawCircle(Offset(45.0,100.0), 20.0, paint);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}


class SearchP extends CustomPainter{



  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(35.0, 100.0)
      ..lineTo(size.width - 40  , 50.0)
      ..arcToPoint(Offset(size.width - 15 , 75.0),radius: Radius.circular(25.0))
      ..lineTo(size.width - 45.0, size.height-10.0)
      ..arcToPoint(Offset(size.width - 55, size.height), radius: Radius.circular(10.0))
      ..lineTo(size.width * 0.23 , size.height - 20.0)
      ..arcToPoint(Offset(size.width * 0.23 - 10.0, size.height - 30.0),radius:  Radius.circular(10.0))
      ..lineTo(15.0, 120.0)
      ..arcToPoint(Offset(35.0, 100.0),radius: Radius.circular(20))
      ..close();
    Paint paint = Paint()
    ..color = Colors.lime
    ..strokeWidth = 0.0;
    
    canvas.drawPath(path, paint);
    
    paint.color = Color.fromRGBO(0, 1, 43, 1.0);
    canvas.drawCircle(Offset(60.0,100.0), 25.0, paint);
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

//    Paint paint = Paint();
//    paint.color = Colors.red;
//    Canvas canvas;
//    canvas.drawCircle(Offset(45.0,100.0), 20.0, paint);


}
