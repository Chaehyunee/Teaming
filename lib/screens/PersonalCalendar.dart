library event_calendar;

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';

part 'color-picker.dart';
part 'timezone-picker.dart';
part 'appointment-editor.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: (1==1) || (1==1)
        ? const FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://teaming-7202b-default-rtdb.firebaseio.com/',
    )
        : const FirebaseOptions(
      appId: '1:297855924061:android:669871c998cc21bd',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      messagingSenderId: '297855924061',
      projectId: 'flutter-firebase-plugins',
      databaseURL: 'https://teaming-7202b-default-rtdb.firebaseio.com/',
    ),
  );
  runApp(MaterialApp(
    title: 'Flutter Database Example',
    home: PersonalCalendar(app: app),
  ));
}*/

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({Key? key /*, required this.app*/}) : super(key: key);

  //final FirebaseApp app;

  @override
  _PersonalCalendarState createState() => _PersonalCalendarState();
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';

class _PersonalCalendarState extends State<PersonalCalendar> {
  //PersonalCalendarState();

  CalendarView _calendarView = CalendarView.week;
  late List<String> eventNameCollection;
  late List<Meeting> appointments;

  @override
  void initState() {
    _calendarView = CalendarView.week;
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actions: <Widget>[
          /*IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                Navigator.pushNamed(context, '/drawer');
              },
              ),*/
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
          child: getEventCalendar(_calendarView, _events, onCalendarTapped)),

      // 드로워(서랍) 추가
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
                      Text("ID:\n"),
                      Text("계정"),
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
      )),
    ));
  }

  SfCalendar getEventCalendar(
      CalendarView _calendarView,
      CalendarDataSource _calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
        view: _calendarView,
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        initialDisplayDate: DateTime.now(),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }

  void onCalendarViewChange(String value) {
    if (value == 'Day') {
      _calendarView = CalendarView.day;
    } else if (value == 'Week') {
      _calendarView = CalendarView.week;
    } else if (value == 'Work week') {
      _calendarView = CalendarView.workWeek;
    } else if (value == 'Month') {
      _calendarView = CalendarView.month;
    } else if (value == 'Timeline day') {
      _calendarView = CalendarView.timelineDay;
    } else if (value == 'Timeline week') {
      _calendarView = CalendarView.timelineWeek;
    } else if (value == 'Timeline work week') {
      _calendarView = CalendarView.timelineWorkWeek;
    }

    setState(() {});
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      if (_calendarView == CalendarView.month) {
        _calendarView = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _isAllDay = meetingDetails.isAllDay;
          _selectedColorIndex =
              _colorCollection.indexOf(meetingDetails.background);
          _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
          _subject = meetingDetails.eventName == '(No title)'
              ? ''
              : meetingDetails.eventName;
          _notes = meetingDetails.description;
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime =
            TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),
        );
      }
    });
  }

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];
    eventNameCollection = <String>[];
    eventNameCollection.add('General Meeting');
    eventNameCollection.add('Plan Execution');
    eventNameCollection.add('Project Plan');
    eventNameCollection.add('Consulting');
    eventNameCollection.add('Support');
    eventNameCollection.add('Development Meeting');
    eventNameCollection.add('Scrum');
    eventNameCollection.add('Project Completion');
    eventNameCollection.add('Release updates');
    eventNameCollection.add('Performance Check');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    _colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    _colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Korea Standard Time');

    final DateTime today = DateTime.now();
    final Random random = Random();
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          meetingCollection.add(Meeting(
            from: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour)),
            to: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour + 2)),
            background: _colorCollection[random.nextInt(9)],
            startTimeZone: '',
            endTimeZone: '',
            description: '',
            isAllDay: false,
            eventName: eventNameCollection[random.nextInt(7)],
          ));
        }
      }
    }

    return meetingCollection;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
}
