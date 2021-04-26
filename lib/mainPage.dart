import 'package:flutter/material.dart';
import 'package:flutter_app/personalCalendar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:date_format/date_format.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(
  MaterialApp(
    title: 'Navigator',
    initialRoute: '/',
    routes: {
      '/': (context) => MainPage(),
      '/second': (context) => PersonalCalender(),
    },
  ),
);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: (){
                    Navigator.pushNamed(context, '/second');
                  },
                ),
              ],
            ),

            body: Column (
              children: [
                section1,
                section2,
                section3,
                section4,
              ]
            ),

            // 드로워(서랍) 추가
            drawer: Drawer(
              // 리스트뷰 추가
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // 드로워해더 추가
                  DrawerHeader(
                    child: Text('Drawer Header'),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  // 리스트타일 추가
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // 네이게이터 팝을 통해 드로워를 닫는다.
                      Navigator.pop(context);
                    },
                  ),
                  // 리스트타일 추가
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {
                      // 드로워를 닫음
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
        )
    );
  }

  Widget section1 = Container(
    // 컨테이너 내부 상하좌우에 32픽셀만큼의 패딩 삽입
    margin: const EdgeInsets.only(top:20.0, left:20.0, right:20.0),
    padding: const EdgeInsets.only(top:20.0, bottom:20.0),
    decoration: BoxDecoration(
        color: const Color(0xffededed),
        border: Border.all(color: Colors.black)
    ),
    // 자식으로 Row 를 추가
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(right:30.0),
            child: TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
              return Text(
                  formatDate(DateTime.now(), [am, ' ', hh, ':', nn, '\n', mm, '. ', dd, '. ']), // add pubspec.yaml the date_format: ^1.0.9
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.w600,
                  )
              );
            })
        ),
        Container(
          padding: const EdgeInsets.only(left:30.0),
            child: Text(
                'temperature°',
              style: TextStyle(
                fontSize: 20
              )
            )
        ),
      ]
    )
  );
  Widget section2 = Container(
    margin: const EdgeInsets.only(top:20.0, left:20.0, right:20.0),
    decoration: BoxDecoration(
        color: const Color(0xffededed),
        border: Border.all(color: Colors.black)
    ),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top:5.0, left: 15.0, bottom: 5.0),
          child: Text(
              '나의 기여도',
              style: TextStyle(
                fontSize: 17
              )
          )
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: LinearPercentIndicator(
            width: 350.0,
            animation: true,
            animationDuration: 1000,
            lineHeight: 25.0,
            percent: 0.2,
            center: Text("20.0%"),
            linearStrokeCap: LinearStrokeCap.butt,
            progressColor: Colors.black,
          )
        ),
      ]
    )
  );
  Widget section3 = Container(
    margin: const EdgeInsets.only(top:20.0, left:20.0, right:20.0),
    decoration: BoxDecoration(
        color: const Color(0xffededed),
        border: Border.all(color: Colors.black)
    ),
    child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top:5.0, left: 15.0, bottom: 5.0),
            child: Text(
                '다음 회의',
                style: TextStyle(
                    fontSize: 17
                )
            )
        ),
      ]
    )
  );
  Widget section4 = Container(
    margin: const EdgeInsets.only(top:20.0, left:20.0, right:20.0),
    decoration: BoxDecoration(
        color: const Color(0xffededed),
        border: Border.all(color: Colors.black)
    ),
    child: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top:5.0, left: 15.0, bottom: 5.0),
            child: Text(
                '새 공지',
                style: TextStyle(
                    fontSize: 17
                )
            )
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top:5.0, left: 15.0, bottom: 5.0),
            child: Text(
                '확인하지 않은 게시글',
                style: TextStyle(
                    fontSize: 17
                )
            )
        ),
      ]
    )
  );
}