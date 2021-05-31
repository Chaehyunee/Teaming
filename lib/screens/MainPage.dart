import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:date_format/date_format.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'loginPage.dart';

class Article {
  static late String title;
  static late String content;
  static late String create;
  static late String author;
  static late String id;
}

class TeamCode {
  static late String code;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String colName = "article";
  final String fdAuthor = "author";
  final String fdTitle = "title";
  final String fdContent = "content";
  final String fdCreate = "create";

  final _TeamKey = GlobalKey<FormState>();

  // 팀 생성 및 참가
  final TextEditingController NameController = TextEditingController();
  final TextEditingController expController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  int T_code = 0;

  List member = [];
  List Team = [];

  Color _noti_color = Color(0xFF283593);
  Color _state_color = Color(0xFF283593);

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

  Stream<QuerySnapshot> articleStream = FirebaseFirestore.instance
      .collection("article")
      .orderBy("create", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바 테마 설정 및 아이콘 생성
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actions: <Widget>[
          IconButton(
            icon: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Color(0xFF283593),
                      ),
                    ],
                  ),
                ),
              ],
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
                              padding: const EdgeInsets.only(right: 25.0),
                              child: TimerBuilder.periodic(Duration(seconds: 1),
                                  builder: (context) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          formatDate(DateTime.now(), [am]),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'SLEIGothic'),
                                        ),
                                        Text(
                                          formatDate(
                                              DateTime.now(), [hh, ':', nn]),
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'SLEIGothic'),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          formatDate(DateTime.now(),
                                              [mm, '월 ', dd, '일']),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'SLEIGothic'),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              })),
                          Container(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: FutureBuilder(
                                  future: getWeather(),
                                  builder: (context,
                                      AsyncSnapshot<Weather> snapshot) {
                                    if (snapshot.hasData == false) {
                                      return CircularProgressIndicator();
                                    }
                                    return Column(
                                      children: [
                                        Text(
                                          "현재 기온은",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'SLEIGothic'),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${snapshot.data!.temp.toString()}°",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontFamily: 'SLEIGothic'),
                                            ),
                                            Text(" 입니다",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'SLEIGothic'))
                                          ],
                                        ),
                                      ],
                                    );
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
                            percent: 0.9,
                            center: Text("90.0%"),
                            linearStrokeCap: LinearStrokeCap.butt,
                            backgroundColor: Colors.deepPurple[50],
                            progressColor: Colors.deepPurple[400],
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              child: Text("게시물 새로고침"),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                setState(() {
                  colName = "article";
                  colName = colName + TeamCode.code;
                  articleStream = FirebaseFirestore.instance
                      .collection(colName)
                      .orderBy(fdCreate, descending: true)
                      .snapshots();
                });
              },
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
                stream:
                    /*FirebaseFirestore.instance
                    .collection(colName + TeamCode.code)
                    .orderBy(fdCreate, descending: true)
                    .snapshots()*/
                    articleStream,
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
                          dt = dt.substring(0, 16);
                          String content;
                          if (document[fdContent].length > 55) {
                            content = document[fdContent].substring(0, 55);
                          } else {
                            content = document[fdContent];
                          }
                          return Card(
                            color: Theme.of(context).primaryColorLight,
                            elevation: 2,
                            child: InkWell(
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
                                            color: Colors.grey[800],
                                            fontFamily: 'GyeonggiCheonnyeon',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        content,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'GyeonggiCheonnyeon',
                                        ),
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
      drawer: Drawer(
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
                /*CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFF283593),
                ),*/
                Container(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "이름: ${UserData.userName}",
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        "계정: ${UserData.userEmail}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 회의 가능 시간
          GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                width: 265,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Color(0xFF868484)),
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "회의 가능 시간",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )),

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

          // 팀 정보 화면
          Container(
            height: 330,
            width: 265,
            decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                border: Border.all(color: Color(0xFF868484)),
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("팀명"),
                for (String name in member) print_member(name)
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
                            onPressed: () {}),
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
                    icon: Icon(Icons.notifications, color: _noti_color),
                    onPressed: () {
                      setState(() {
                        _noti_color = _noti_color == Color(0xFF283593)
                            ? Colors.grey
                            : Color(0xFF283593);
                      });
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
      )),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/createarticle');
        },
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
    );
  }

  // 팀 선택 화면 출력 함수
  void show_Team_sel() async {
    await FirebaseFirestore.instance
        .collection("Team")
        .doc("Team_List")
        .get()
        .then((DocumentSnapshot ds) {
      Team = ds.get("T_name");
    });

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
                  for (String name in Team) print_Team(name),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.add_circle,
                      color: Color(0xFF283593),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      create_Team();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  // 팀 생성 화면 출력 함수

  void create_Team() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: 250,
                child: Form(
                    key: _TeamKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("팀을 새로 만드시겠습니까?"),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "팀명을 입력해 주세요.",
                                    border: OutlineInputBorder()),
                                controller: NameController,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "팀에 대한 설명을 입력해주세요.",
                                    border: OutlineInputBorder()),
                                controller: expController,
                              ),
                              SizedBox(height: 10),
                              RaisedButton(
                                  child: Text(
                                    "생성",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF283593),
                                  onPressed: () {
                                    int rng = Random().nextInt(50) + 1;
                                    firebaseFirestore
                                        .collection("Team")
                                        .doc(NameController.text)
                                        .set({
                                      "code": rng,
                                      "name": NameController.text,
                                      "explanation": expController.text,
                                      "member": [UserData.userName]
                                    });
                                    firebaseFirestore
                                        .collection("Team")
                                        .doc("Team_List")
                                        .update({
                                      "T_name": FieldValue.arrayUnion(
                                          <dynamic>[NameController.text])
                                    });
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),
                      ],
                    ))),
          );
        });
  }

  // 팀원 정보 변경
  void change_member(String Team_Name) async {
    await FirebaseFirestore.instance
        .collection("Team")
        .doc(Team_Name)
        .get()
        .then((DocumentSnapshot ds) {
      member = ds.get("member");
    });
  }

  // 팀 목록 출력
  print_Team(String name) {
    return FlatButton(
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
              name,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      onPressed: () async {
        change_member(name);
        await FirebaseFirestore.instance
            .collection("Team")
            .doc(name)
            .get()
            .then((DocumentSnapshot ds) {
          T_code = ds.get("code");
          TeamCode.code = T_code.toString();
        });
        print(T_code);
        Navigator.pop(context);
      },
    );
  }

  // 팀원 목록 출력
  print_member(String name) {
    return FlatButton(
      child: Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Color(0xFF868484)),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
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
              name,
              style: TextStyle(color: Colors.white),
            )
          ])),
      onPressed: () {
        print(name);
      },
    );
  }

  // 문서 조회 (Read)
  void showDocument(String id) async {
    await FirebaseFirestore.instance
        .collection(colName)
        .doc(id)
        .get()
        .then((doc) {
      Article.title = doc[fdTitle];
      Article.content = doc[fdContent];
      Article.create = timestampToStrDateTime(doc[fdCreate]);
      Article.author = doc[fdAuthor];
      Article.id = id;
    });
    Navigator.pushNamed(context, '/showarticle');
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
