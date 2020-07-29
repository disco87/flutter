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
    return Scaffold(
      appBar: AppBar(
        title: Text('나의 레시피'),
      ),
      body: FutureBuilder(
        future: DBHelper().foods(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                FoodModel fd = snapshot.data[index];
                print(fd.imgUrl);
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
                        print(fd.siteUrl.toString());
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
    );
  }
}
