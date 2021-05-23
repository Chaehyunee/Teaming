import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:date_format/date_format.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String colName = "article";

  final String fdAuthor = "author";
  final String fdTitle = "title";
  final String fdContent = "content";
  final String fdCreate = "create";

  Future<Weather> getWeather() async {
    String apiAddr =
        "https://api.openweathermap.org/data/2.5/weather?q=chinju&appid=cda9837ae57b0889263fb4cc83fbb2e2&units=metric";
    http.Response response = await http.get(Uri.parse(apiAddr));
    var data1 = json.decode(response.body);
    Weather weather = Weather(
      temp: data1["main"]["temp"],
      tempMax: data1["main"]["temp_max"],
      tempMin: data1["main"]["temp_min"],
    );

    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바 테마 설정 및 아이콘 생성
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.circle,
              color: Color(0xFF283593),
            ),
            onPressed: () {
              show_Team_sel();
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      ),

      // 4개의 섹션을 모두 감싸는 바디를 컨테이너 생성
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            // 컬럼으로 자식을 생성
            child: Column(
              // 컬럼안에는 4개의 컨테이너 타입의 자식이 존재
              children: [
                // 1번 섹션 (시간, 온도)
                Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Color(0xFF868484)),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: TimerBuilder.periodic(Duration(seconds: 1),
                                  builder: (context) {
                                return Text(
                                    formatDate(DateTime.now(), [
                                      am,
                                      ' ',
                                      hh,
                                      ':',
                                      nn,
                                      '\n',
                                      mm,
                                      '. ',
                                      dd,
                                      '. '
                                    ]), // add pubspec.yaml the date_format: ^1.0.9
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      //fontWeight: FontWeight.w600,
                                    ));
                              })),
                          Container(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: FutureBuilder(
                                  future: getWeather(),
                                  builder: (context,
                                      AsyncSnapshot<Weather> snapshot) {
                                    if (snapshot.hasData == false) {
                                      return CircularProgressIndicator();
                                    }
                                    return Text(
                                        '${snapshot.data!.temp.toString()}°');
                                  })),
                        ])),

                // 2번 섹션 (기여도 표시부분)
                Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Color(0xFF868484)),
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 15.0, bottom: 5.0),
                          child:
                              Text('나의 기여도', style: TextStyle(fontSize: 17))),
                      Container(
                          alignment: Alignment.center,
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10.0),
                          child: LinearPercentIndicator(
                            width: 330.0,
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 25.0,
                            percent: 0.2,
                            center: Text("20.0%"),
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.black,
                          )),
                    ])),

                // 3번 섹션 (다음 회의 일정 표시 부분)
                Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Color(0xFF868484)),
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 15.0, bottom: 5.0),
                          child: Text('다음 회의', style: TextStyle(fontSize: 17))),
                    ])),

                // 4번 섹션 (새 공지와 확인하지 않은 게시글 표시 부분)
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.only(left: 17, right: 17),
              height: 500,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(colName)
                    .orderBy(fdCreate, descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("Loading...");
                    default:
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Timestamp ts = document[fdCreate];
                          String dt = timestampToStrDateTime(ts);
                          return Card(
                            elevation: 2,
                            child: InkWell(
                              // Read Document
                              onTap: () {
                                showDocument(document.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          document[fdTitle],
                                          style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          dt.toString(),
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        document[fdContent],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              )),
        ],
      ),

      // 애플리케이션 좌측 부분 서랍

   /*   drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          // 상단 프로필 이미지, ID 및 계정, 상태전환 버튼
            Container(
            height: 75,
            width: 295,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFF283593),
                ),
                Container(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("이름:\n"),
                      Text("E-mail:"),
                    ],
                  ),
                ),
                IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.remove_circle,
                      color: Color(0xFF283593),
                    ),
                    onPressed: () {})
              ],
            ),
          ),

          // 회의 가능 시간
          Container(
            height: 50,
            width: 265,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Color(0xFF868484)),
                borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "회의 가능 시간:",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

          // 모임 가능한 장소
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              child: Container(
                height: 50,
                width: 265,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Color(0xFF868484)),
                    borderRadius: BorderRadius.circular(18)),
                //padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "모임 가능한 장소",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
              Container(
                height: 50,
                width: 265,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Color(0xFF868484)),
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "모임 가능한 장소: ",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),

              // 팀 정보 화면
              Container(
                height: 330,
                width: 265,
                decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    border: Border.all(color: Color(0xFF868484)),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "팀명",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Color(0xFF868484)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "팀원이름",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Color(0xFF868484)),
                      borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "팀원이름",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Color(0xFF868484)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "팀원이름",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Color(0xFF868484)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "팀원이름",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            IconButton(
                                iconSize: 40,
                                icon: Icon(
                                  Icons.circle,
                                  color: Color(0xFF283593),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/article');
                                }),
                            Text(
                              "AM/PM",
                              style: TextStyle(fontSize: 8, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.notifications, color: Color(0xFF283593)),
                        onPressed: () {
                          setState(() {});
                        }),
                    IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.palette, color: Color(0xFF283593)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/themeSetting');
                        }),
                  ],
                ),
              )
            ],
          )
      ),*/
    );
  }

  // 팀 선택 화면 출력 함수
  // ignore: non_constant_identifier_names
  void show_Team_sel() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFEDEDED),
            content: Container(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    child: Container(
                      height: 70,
                      width: 250,
                      color: Color(0xFF9FA8DA),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "그룹명 1",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Container(
                      height: 70,
                      width: 250,
                      color: Color(0xFF9FA8DA),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFF283593),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "그룹명 2",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.add_circle,
                      color: Color(0xFF283593),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        });
  }

  // 팀 생성 화면 출력 함수
  // ignore: non_constant_identifier_names
  void create_Team() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              child: Column(
                children: [],
              ),
            ),
          );
        });
  }

  // 문서 조회 (Read)
  void showDocument(String id) {
    FirebaseFirestore.instance.collection(colName).doc(id).get().then((doc) {
      showReadDocSnackBar(doc);
    });
  }

  void showReadDocSnackBar(DocumentSnapshot doc) {
    _scaffoldKey.currentState!
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 5),
          content:
              Text("$fdTitle: ${doc[fdTitle]}\n$fdContent: ${doc[fdContent]}"
                  "\n$fdCreate: ${timestampToStrDateTime(doc[fdCreate])}"),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}

class Weather {
  final double temp; //현재 온도
  final double tempMin; //최저 온도
  final double tempMax; //최고 온도

  Weather({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });
}
