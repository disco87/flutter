import "package:animator/animator.dart";
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'MyWebView.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  Color btColor = Colors.black;
  var _textEditingController = TextEditingController();
  List<String> _foodlist = [];
  Set<String> _foodlist2 = {};
  Future<List<Map>> urlList;
  bool reSearch = false;
  List<Color> myColor = [
    Colors.redAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
    Colors.blueAccent,
    Colors.deepPurpleAccent,
    Colors.limeAccent
  ];
  List rand = [0, 1, 2, 3, 4, 5];
  void addItem(String txt) {
    setState(() {
      _foodlist.insert(0, txt);
    });
  }

  // void reFresh() {
  //   setState(() {
  //     wait = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    rand.shuffle();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: h,
          color: Color.fromRGBO(252, 250, 242, 0.5),
          child: Stack(
            children: <Widget>[
              Positioned(
                //url List View
                top: h * 0.40,
                child: FutureBuilder(
                  future: urlList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    List<Map> content = snapshot.data;
                    reSearch ? content.clear() : print('');
                    // content.length > 0 ? wait = false : print('$wait' + '1111');

                    return snapshot.connectionState == ConnectionState.done
                        ? Container(
                            color: Colors.red.withAlpha(0),
                            width: w,
                            height: h * 0.6,
                            alignment: Alignment(0.0, 0.0),
                            child: ListView.builder(
                              padding: EdgeInsets.all(8.0),
                              itemCount: content.length + 1,
                              itemBuilder: (context, index) => index > 0
                                  ? Container(
                                      margin: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            Color.fromRGBO(243, 245, 213, 0.2),
                                            Color.fromRGBO(166, 206, 255, 0.2),
                                            Color.fromRGBO(199, 118, 219, 0.13),
                                          ],
                                              stops: [
                                            0.25,
                                            0.65,
                                            1
                                          ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight)),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(3),
                                        leading: Container(
                                            width: 80,
                                            height: 80,
                                            child: Image.network(
                                              content[index - 1]['imgUrl'],
                                              fit: BoxFit.cover,
                                            )),
                                        title: Text(
                                          content[index - 1]['text'],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        onTap: () => Navigator.pushNamed(
                                            context, '/MyWebView',
                                            arguments: MyWebArgs(
                                              content[index - 1]['text'],
                                              content[index - 1]['url'],
                                              content[index - 1]['imgUrl']
                                            )),
                                      ),
                                    )
                                  : Container(
                                      height: 50,
                                    ),
                            ),
                          )
                        : Container(
                            width: w,
                            height: h * 0.5,
                            alignment: Alignment.center,
                            child: Text(
                              'Wait....',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blueGrey[300],
                              ),
                            ));
                  },
                ),
              ),
              Container(
                child: ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    height: h * 0.45,
                    width: w * 1,
                    transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.amber, Colors.amberAccent],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                    ),
                    child: Image.asset(
                      'assets/images/foods.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: h * 0.042,
                  left: 42,
                  child: Text(
                    '냉장고를 털어라',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  )),
              Positioned(
                  top: h * 0.033,
                  left: 10,
                  child: Container(
                    width: 30.0,
                    child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        elevation: 0.0,
                        color: Colors.transparent,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(50.0),
                        // ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/');
                          // Navigator.pushReplacementNamed(context, '/');
                          Navigator.pop(context);
                          print('click');
                        }),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(0, h / 4.5, 0, 0),
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      width: w * 0.6,
                      child: TextField(
                        controller: _textEditingController,
                        maxLength: 15,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            wordSpacing: 0.0),
                        decoration: InputDecoration(
                            hintText: '재료를 입력하세요',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            contentPadding: EdgeInsets.only(left: 5.0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Container(
                      //아이템 장바구니 담기버튼
                      width: 60.0,
                      margin: EdgeInsets.fromLTRB(0, 5, 30, 0),
                      child: RaisedButton(
                          child: Image.asset(
                            'assets/images/iconadd.png',
                            width: 30.0,
                            height: 30.0,
                          ),
                          color: Colors.transparent,
                          elevation: 0.0,
                          splashColor: Colors.red,
                          onPressed: () {
                            String chk = _textEditingController.text.trim();
                            if (chk != '' && _foodlist.length < 5) {
                              addItem(chk);
                              FocusScope.of(context).requestFocus(FocusNode());
                              reSearch = true;
                            }
                            FocusScope.of(context).requestFocus(FocusNode());
                            _textEditingController.clear();
                          }),
                    ),
                  ],
                ),
              ),
              Positioned(
                //재료 리스트
                top: h * 0.43,
                child: Container(
                  width: _foodlist.length > 0 ? w : 0,
                  height: _foodlist.length > 0 ? h * 0.57 : 0,
                  color: Colors.transparent,
                  child: ListView.builder(
                    itemCount: _foodlist.length,
                    itemBuilder: (context, index) {
                      final item = _foodlist[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            _foodlist.removeAt(index);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 3.0),
                          decoration: BoxDecoration(
                              color: myColor[rand[index]],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(30.0),
                              )),
                          child: ListTile(
                            title: Text(
                              '$item',
                              textAlign: TextAlign.center,
                            ),
                            trailing: Wrap(
                              spacing: 5,
                              children: <Widget>[
                                SizedBox(
                                  width: 30.0,
                                  child: FlatButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        setState(() {
                                          _foodlist.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                      )),
                                )
                              ],
                            ),
                            onLongPress: () {
                              setState(() {
                                print('delete');
                                print(_foodlist);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  top: h * 0.45 - 65.0,
                  left: w * 0.5 - 45,
                  child: Align(
                    // alignment: Alignment.bottomCenter,
                    child: Animator(
                      duration: Duration(milliseconds: 550),
                      cycles: 0,
                      tween: Tween<double>(begin: 0.85, end: 1.05),
                      curve: Curves.easeInOut,
                      builder: (context, animatorState, child) =>
                          RawMaterialButton(
                              elevation: 12.0,
                              child: Image.asset(
                                'assets/images/cookIcon.png',
                                color: btColor,
                                fit: BoxFit.cover,
                                width: _foodlist.length > 0
                                    ? 40.0 * animatorState.value
                                    : 40.0,
                                height: _foodlist.length > 0
                                    ? 40.0 * animatorState.value
                                    : 40.0,
                              ),
                              fillColor: Colors.blue[200],
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15.0),
                              onPressed: () {
                                print('조리하기');
                                if (_foodlist.length > 0) {
                                  setState(() {
                                    urlList = scrap_web(_foodlist);
                                    _foodlist.clear();
                                    _foodlist2.clear();
                                    reSearch = false;
                                    // wait = true;
                                  });
                                }
                              }),
                    ),
                  )),
            ],
          ),
        ),
      ),

    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 65.0;
    Path path = Path();
    // path.moveTo(0.0, 0.0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
//    throw UnimplementedError();
    return true;
  }
}

Future<List<Map>> scrap_web(List<String> listUrl) async {
  String base_url = 'https://search.naver.com/search.naver?where=post&query=';
  // String base_url = 'https://www.10000recipe.com/recipe/list.html?q=';
  List<Map> urlList = [];
  for (var i in listUrl) {
    base_url += i + '%26';
  }
  base_url += '%26요리';
  var response = await http.get(base_url);
  // final webScraper = WebScraper('https://webscraper.io');
  if (response.statusCode == 200) {
    print('Complete');
    var document = parse(response.body);
    //네이버
    var imgLink = document.getElementsByClassName('sp_thmb');
    var txtLink = document.getElementsByClassName('sh_blog_title');
    //만개의 레시피
    // var imgLink = document.getElementsByClassName('thumbnail'); //이미지 & url
    // var txtLink = document.getElementsByClassName('caption'); //text

    for (int i = 0; i < imgLink.length; i++) {
      urlList.add({
        'imgUrl': imgLink[i].firstChild.attributes['src'],
        'text': txtLink[i].text,
        'url': txtLink[i].attributes['href'],
      });
    }
  } else {
    print('failed');
  }

  // print(urlList[0]['imgUrl']);
  return urlList;
}

// https://search.naver.com/search.naver?where=nexearch&query=%EA%B0%90%EC%9E%90 //전체
// https://search.naver.com/search.naver?where=post&query=%EA%B0%90%EC%9E%90 //블로그
// https://search.naver.com/search.naver?where=video&query=%EA%B0%90%EC%9E%90 //비디오
// https://m.post.naver.com/search/post.nhn?keyword=고구마 //포스트
