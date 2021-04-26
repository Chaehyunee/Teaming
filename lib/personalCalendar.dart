import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PersonalCalender extends StatefulWidget {
  @override
  _PersonalCalenderState createState() => _PersonalCalenderState();
}

class _PersonalCalenderState extends State<PersonalCalender> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Container (
              child: SfCalendar(
                view: CalendarView.week,
              ),
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
}

