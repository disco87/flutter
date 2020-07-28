import 'dart:async';
import 'package:flutter/material.dart';
import 'package:footsaerch/db/db_helper.dart';
import 'package:footsaerch/model/foodmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  saveDB(String title, String url, String imgUrl) async{
    print('$title, $url, $imgUrl');
    DBHelper sd = DBHelper();
//    var res = FoodModel(
//      id: 1,
//      title: title,
//      siteUrl: url,
//      imgUrl: url,
//      date: DateTime.now().toString(),
//    );
//    await sd.createFoodData(res);
    print(await sd.foodAllRead());
  }

  @override
  Widget build(BuildContext context) {
    final MyWebArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
      floatingActionButton: FlatButton(

        color: Colors.red,
          onPressed: (){
            saveDB(args.title, args.url, args.imgUrl);
            setState(() {
              
            });
          }, child: Text('레시피 저장')
      ),
    );

  }
}

class MyWebArgs {
  String title;
  String url;
  String imgUrl;
  MyWebArgs(this.title, this.url,this.imgUrl);
}
