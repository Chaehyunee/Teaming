import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/teaming_logo.png', scale: 3),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Naver',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.green[700],
                            onPressed: () {
                              //화면 연결 to 네이버 로그인 창
                            },
                          ),
                          RaisedButton(
                            child: Text('Kakao',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.amber[700],
                            onPressed: () {
                              //화면 연결 to 카카오톡 로그인 창
                            },
                          ),
                          RaisedButton(
                            child: Text('Google',
                                style: TextStyle(color: Colors.white)),
                            color: Colors.red[800],
                            onPressed: () {
                              //화면 연결 to 구글 로그인 창
                            },
                          )
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.white70,
                          width: 250,
                          height: 140,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new TextField(
                                decoration: const InputDecoration(
                                    labelText: 'ID',
                                    border: OutlineInputBorder()),
                                onChanged: (text) {
                                  setState(() {
                                    // _IDfieldtext = text;
                                  });
                                },
                              )),
                              new Flexible(
                                child: new TextField(
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
                              child: Text('Login',
                                  style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                Navigator.pushNamed(context, '/mainPage');
                              },
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                            minWidth: 130.0,
                            height: 30.0,
                            child: RaisedButton(
                              child: Text('회원가입',
                                  style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                //화면 연결 to 회원가입 창
                                Navigator.pushNamed(context, '/signup');
                              },
                            )),
                        ButtonTheme(
                            minWidth: 130.0,
                            height: 30.0,
                            child: RaisedButton(
                              child: Text('ID/PW 찾기',
                                  style: TextStyle(color: Colors.black)),
                              color: Colors.blue[200],
                              onPressed: () {
                                //화면 연결 to ID/PW 찾기 창
                              },
                            ))
                      ],
                    )
                  ]),
            )));
  }
}
