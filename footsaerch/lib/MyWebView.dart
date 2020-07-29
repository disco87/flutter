import 'dart:async';
import 'package:flutter/material.dart';
import 'package:footsaerch/control/dbhelper.dart';
import 'package:footsaerch/model/foodmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'control/dbhelper.dart';
import 'package:intl/intl.dart';


class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  DateFormat dateFormat = DateFormat('yyyy-mm-dd HH:MM');
  bool _complete;
  final GlobalKey<ScaffoldState> _snackKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _complete = false;

  }

  saveDB(String title, String url, String imgUrl) async{
    _complete = true;
    DBHelper sd = DBHelper();
    var res = FoodModel(
//      id: 1,
      title: title,
      siteUrl: url,
      imgUrl: imgUrl,
      date: dateFormat.format(DateTime.now()).toString(),
    );
    await sd.insertFood(res);
    print(await sd.foods());
  }

  @override
  Widget build(BuildContext context) {
    final MyWebArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _snackKey,
      appBar: AppBar(
        title: Text(args.title),
      ),

      body: SafeArea(
        child: WebView(
          initialUrl: args.url,
          // onWebViewCreated: (WebViewController webViewController) {
          //   _controller.complete(webViewController);
          // },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      floatingActionButton: args.recipeSave?FloatingActionButton(
          onPressed: (){
            if(_complete == false){
              saveDB(args.title, args.url, args.imgUrl);
              setState(() {
                _snackKey.currentState.showSnackBar(SnackBar(
                    content: Text('레시피 저장 완료!',textAlign: TextAlign.center,),duration: Duration(seconds: 1),));
              });
            }
            setState(() {
              args.recipeSave = false;
            });
          },
          child: Icon(Icons.save),
        mini: false,
        backgroundColor: Colors.red,
        foregroundColor: Colors.lime,

      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

  }
}

class MyWebArgs {
  String title;
  String url;
  String imgUrl;
  bool recipeSave;
  MyWebArgs(this.title, this.url,this.imgUrl,this.recipeSave);
}

