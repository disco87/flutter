import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HealthWeb extends StatefulWidget {
  @override
  _HealthWebState createState() => _HealthWebState();
}

class _HealthWebState extends State<HealthWeb> {
  @override
  Widget build(BuildContext context) {
    // final MyWebArgs args = ModalRoute.of(context).settings.arguments;
    final MyWebArgs arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${arg.title}'),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: arg.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}

class MyWebArgs {
  String title;
  String url;
  MyWebArgs(this.title, this.url);
}
