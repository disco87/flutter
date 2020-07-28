import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
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
          onPressed: (){}, child: Text('레시피 저장')
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
