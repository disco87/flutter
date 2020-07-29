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
        Positioned(
          top: 0,
          child: SizedBox(
            width: size.width,
            height: size.height * 0.5,
            child: ClipPath(
              clipper: SearchPainter(),
              child: Container(
                width: 350.0,
                height: 240.0,
                color: Colors.lime,
              ),
            ),
          ),
        ),
        ]
      ),
    );
  }
}




class SearchPainter extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final double myRound = 50.0;
    Path path = Path()
      ..moveTo(50.0, 100.0)
      ..lineTo(size.width - myRound  , 0.0)
      ..lineTo(310.0, size.height)

      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

}
