import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('게시판'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            color: Colors.blue[200],
                            width: 350,
                            height: 100,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('공지사항'),
                                  TextFormField()
                                ])),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child:
                              Text('투표', style: TextStyle(color: Colors.black)),
                          color: Colors.green[200],
                          onPressed: () {
                            //화면 연결 to 네이버 로그인 창
                          },
                        ),
                        RaisedButton(
                          child: Text('다음 회의시간',
                              style: TextStyle(color: Colors.black)),
                          color: Colors.green[200],
                          onPressed: () {
                            //화면 연결 to 카카오톡 로그인 창
                          },
                        ),
                        RaisedButton(
                          child: Text('팀원 기여도',
                              style: TextStyle(color: Colors.black)),
                          color: Colors.green[200],
                          onPressed: () {
                            //화면 연결 to 구글 로그인 창
                          },
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            color: Colors.blue[200],
                            width: 350,
                            height: 300,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('그룹 게시판'),
                                  TextFormField(),
                                  TextFormField(),
                                  TextFormField(),
                                  TextFormField(),
                                  TextFormField(),
                                ])),
                      ]),
                ]))));
  }
}
