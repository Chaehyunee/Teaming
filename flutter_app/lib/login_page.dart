import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/board_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text('Teaming'),
      //),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget> [
                    Image.asset(
                        'assets/teaming_logo.png',
                        scale: 3
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Naver', style: TextStyle(color: Colors.white)),
                            color: Colors.green[700],
                            onPressed: () {
                              //화면 연결 to 네이버 로그인 창
                            },
                          ),
                          RaisedButton(
                            child: Text('Kakao', style: TextStyle(color: Colors.white)),
                            color: Colors.amber[700],
                            onPressed: () {
                              //화면 연결 to 카카오톡 로그인 창
                            },
                          ),
                          RaisedButton(
                            child: Text('Google', style: TextStyle(color: Colors.white)),
                            color: Colors.red[800],
                            onPressed: () {
                              //화면 연결 to 구글 로그인 창
                            },
                          )

                        ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.white70,
                          width: 250,
                          height: 140,
                          padding: const EdgeInsets.all(10.0),
                          child: Column (
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(child: new TextField(
                                decoration: const InputDecoration(
                                    labelText: 'ID',
                                    border: OutlineInputBorder()),
                                onChanged: (text) {
                                  setState(() {
                                    // _IDfieldtext = text;
                                  });
                                },
                              )
                              ),
                              new Flexible(child: new TextField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    labelText: '비밀번호',
                                    border: OutlineInputBorder()),
                                onChanged: (text) {
                                  setState(() {
                                    // _PWfieldtext = text;
                                  });
                                },
                              ),
                              ),
                            ],
                          ),
                        ),
                        ButtonTheme(
                            minWidth: 5.0,
                            height: 120.0,
                            child: RaisedButton(
                              child: Text('Login', style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BoardPage()),
                                );
                              },
                            )
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        ButtonTheme(
                            minWidth: 130.0,
                            height: 30.0,
                            child: RaisedButton(
                              child: Text('회원가입', style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                //화면 연결 to 회원가입 창
                              },
                            )
                        ),
                        ButtonTheme(
                            minWidth: 130.0,
                            height: 30.0,
                            child: RaisedButton(
                              child: Text('ID/PW 찾기', style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                //화면 연결 to ID/PW 찾기 창
                              },
                            )
                        )
                      ],
                    )
                  ]
              ),
            )
        )
    );
  }
}