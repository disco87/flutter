
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
  bool isSearch = false;
  String bufferTitle, title;
  List<FoodModel> myList;
  var _textEditingController = TextEditingController();

//  mySearch(){
//    FocusScope.of(context).requestFocus(FocusNode());
//    print(title);
//    if(title == null || title == ''){
//      isSearch = false;
//    }else{
//      isSearch = true;
//      bufferTitle = title;
//      _textEditingController.clear();
//      title = '';
//    }
//  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 레시피'),
      ),
      body: Stack(
          children:<Widget>[
            //DB의 데이터를 화면에 뿌리기 위한 FutureBuilder
            FutureBuilder(
            future: isSearch?DBHelper().searchFood(bufferTitle):DBHelper().foods(),
            builder: (context, snapshot) {
              if(snapshot.data.length > 0){
                print(snapshot.data.length);
                return ListView.builder(//FutureBuilder에서 받아온 데이터를 리스트 형식으로 뿌려준다.
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    FoodModel fd = snapshot.data[index];
                    return Dismissible(//ListTile을 지우기 위한 Widget
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
                            arguments: MyWebArgs(fd.title, fd.siteUrl, fd.imgUrl, false),//웹뷰 페이지에 인자를 전달
                          );
                        },
                      ),
                    );
                  },
                );
              }else return Center(child: Text("저장된 정보가 없습니다.", style: TextStyle(color: Colors.grey[600],fontSize: 18.0),),);
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
                        Positioned(//닫기
                            top:75.0,
                            left: 35.0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isSelect =! isSelect;
                                  _textEditingController.clear();
                                  FocusScope.of(context).requestFocus(FocusNode());
                                });
                              },
                              child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Color.fromRGBO(0, 1, 43, 1),
                                  child: Icon(Icons.close,color: Colors.limeAccent,)),
                            )),
                        Positioned(//제목
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
                        Positioned(//텍스트필드
                            top: 180.0,
                            left: size.width * 0.2,
                            child: Container(
                              width: 250.0,
                              child: TextField(
                                controller: _textEditingController,
                                onChanged: (value) => this.title = value,
//                                textInputAction: mySearch(),
                                decoration: InputDecoration(
                                  hintText: '검색어를 입력해하세요.',
                                  icon: Icon(Icons.search),

                                ),
                              ),
                            )),
                        Positioned(//검색 버튼
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
                                onPressed: (){
                                  setState(() {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    isSelect = !isSelect;
                                    print(title);
                                    if(title == null || title == ''){
                                      isSearch = false;
                                    }else{
                                      isSearch = true;
                                      bufferTitle = title;
                                      _textEditingController.clear();
                                      title = '';
                                    }

                                  });
                                })),

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
