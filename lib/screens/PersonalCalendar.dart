library event_calendar;

//import 'dart:html';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

part 'color-picker.dart';
part 'timezone-picker.dart';
part 'appointment-editor.dart';

class PersonalCalendar extends StatefulWidget {
  const PersonalCalendar({Key? key}) : super(key: key);

  @override
  _PersonalCalendarState createState() => _PersonalCalendarState();
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
List<String> _keyList = <String> [];
late DataSource _events;//데이터 소스 이벤트
Meeting? _selectedAppointment;
/////////////////////////////////
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';
String _eventNameString =  '';
// ignore: non_constant_identifier_names
int selectedColorIndex = 0;
int calendar_counter = 0;


// ignore: non_constant_identifier_names
Color _noti_color = Color(0xFF283593);
// ignore: non_constant_identifier_names
Color _state_color = Color(0xFF283593);

// 팀 생성 및 참가
// ignore: non_constant_identifier_names
final TextEditingController NameController = TextEditingController();
final TextEditingController expController = TextEditingController();
// ignore: non_constant_identifier_names
final TextEditingController InviteController = TextEditingController();

// 팀 이름
// ignore: non_constant_identifier_names
final TextEditingController Team1Controller = TextEditingController();
// ignore: non_constant_identifier_names
final TextEditingController Team2Controller = TextEditingController();

// 팀원 이름
final TextEditingController member1Controller = TextEditingController();
final TextEditingController member2Controller = TextEditingController();
final TextEditingController member3Controller = TextEditingController();
final TextEditingController member4Controller = TextEditingController();

final TextEditingController subjectController = TextEditingController();

final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
DatabaseReference underuid = new FirebaseDatabase().reference().child("UserId").child(uid!);
DatabaseReference dbRef = new FirebaseDatabase().reference().child("UserId");
DatabaseReference test = new FirebaseDatabase().reference().child("CalendarAppointmentCollection");


List member = [];

class _PersonalCalendarState extends State<PersonalCalendar> {

  CalendarView _calendarView = CalendarView.week;
  late List<String> eventNameCollection;
  late List<Meeting> appointments;

  late CalendarController _controller;


  // ignore: close_sinks
  StreamController<String> streamController = StreamController<String>();


  @override
  void initState(){
    _controller=CalendarController();
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

  String inputValue = "";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.color,
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: getEventCalendar(_calendarView, _events, onCalendarTapped),
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
                              color: _state_color,
                            ),
                            onPressed: () {
                              setState(() {
                                _state_color = _state_color == Color(0xFF283593) ?
                                Colors.grey : Color(0xFF283593);
                              });
                            })
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
                          "회의 가능 시간",
                          style: TextStyle(color: Colors.black),
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
                        Text("팀명"),
                        FlatButton(
                          child: Container(
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
                                  member1Controller.text,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            print(member1Controller.text);
                          },
                        ),
                        FlatButton(
                          child: Container(
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
                                  member2Controller.text,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            print(member2Controller.text);
                          },
                        ),
                        FlatButton(
                          child: Container(
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
                                  member3Controller.text,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            print(member3Controller.text);
                          },
                        ),
                        FlatButton(
                          child: Container(
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
                                  member4Controller.text,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            print(member4Controller.text);
                          },
                        ),
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

                                    }
                                ),
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
                            icon: Icon(
                                Icons.notifications,
                                color: _noti_color
                            ),
                            onPressed: () {
                              setState(() {
                                _noti_color = _noti_color == Color(0xFF283593) ?
                                Colors.grey : Color(0xFF283593);
                              });
                            }),
                        IconButton(
                            iconSize: 40,
                            icon: Icon(
                                Icons.palette,
                                color: Color(0xFF283593)
                            ),
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
        controller: _controller,
        dataSource: _events,
        onTap: onCalendarTapped,
        initialDisplayDate: DateTime.now(),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: TimeSlotViewSettings(
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }

  void onCalendarViewChange(String value) {//캘린더 양식 변경 함수
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

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {//캘린더가 탭 되면
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
      /*  firebaseFirestore.collection('calendar_counter').doc('UID').set({
          "counter": calendar_counter++,
        });*/
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),//일정 편집 화면으로
        );
      }
    });
  }

  List<Meeting> getMeetingDetails() {


    List<Meeting> meetingCollection = <Meeting>[];

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0654A3));
    _colorCollection.add(const Color(0xFF0090B9));
    _colorCollection.add(const Color(0xFF397128));
    _colorCollection.add(const Color(0xFF9ED8A1));
    _colorCollection.add(const Color(0xFFFED46E));
    _colorCollection.add(const Color(0xFFB191BD));
    _colorCollection.add(const Color(0xFFF55354));
    _colorCollection.add(const Color(0xFF9F8170));
    _colorCollection.add(const Color(0xFF8D8C88));

    _colorNames = <String>[];
    _colorNames.add('회사');
    _colorNames.add('학교');
    _colorNames.add('여가');
    _colorNames.add('운동');
    _colorNames.add('기념일');
    _colorNames.add('약속');
    _colorNames.add('과제');
    _colorNames.add('생일');
    _colorNames.add('시험');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Korea Standard Time');//한국 시간대

    //Stream.fromFuture(getData()).listen((event) {meetingCollection = event;});

    getData() async {
      await Future.delayed(Duration(seconds: 3)); // 5초간 대기
      print("Fetched Data");

      final DateTime today = DateTime.now();
      final Random random = Random();

      List<Meeting> meetingCollection = <Meeting>[];

      calendar_counter =2;
      print("00000 되나");

      underuid.once().then((DataSnapshot snapshot) {
        calendar_counter = snapshot.value == null? 0 : snapshot.value['counter'];
        print(calendar_counter);
        print("11111counter가 되나");
      });

      await Future.delayed(Duration(seconds: 3)); // 5초간 대기

      List<String> keys = [];
      firebaseFirestore
          .collection("_keyList")
          .doc(uid!).get().then((DocumentSnapshot ds) {
        print(ds.get("keyname"));
        print("222222222_keyList 되나");
        keys = ds.get("keyname")?.cast<String>();
        print("33333333_keyList 되나");
        print(keys.isEmpty? null : keys.elementAt(0));
        print("44444444_keyList 되나");
      });
      await Future.delayed(Duration(seconds: 3)); // 5초간 대기

      print('5555555555');
      int from_days = 0;
      int from_hours = 0;
      int to_days = 0;
      int to_hours = 0;
      int background = 0;
      String startTimeZone = "";
      String endTimeZone = "";
      String description = "";
      String eventName = "";
      bool isAllDay = false;
      String key = "";

      print(calendar_counter);
      print("666666666666counter수");
      for (int i = 0; i < calendar_counter; i++) {
        print('77777777for문이 되나');
        key  = keys.elementAt(i);
        print('888888888이게 되나0');
        underuid.child(key).once().then((DataSnapshot snapshot) {
          print('9999999이게 되나1');
          startTimeZone = snapshot.value['StartDate'];
          print('101010101010이게 되나2');
          endTimeZone = snapshot.value['EndDate'];
          description = snapshot.value['notes'];
          eventName = snapshot.value['Subject'];
          isAllDay = snapshot.value['isAllDay'] == "false" ? false : true;
          background = snapshot.value['selectedColorIndex'];
          print('11 11 11 11이게되나 시작시간존');
          print(startTimeZone);
          print(endTimeZone);
          print(description);
          print(eventName);
          print(isAllDay);
          print(background);
        });
        await Future.delayed(Duration(seconds: 3)); // 5초간 대기
        print(background);

        DateTime date1 = DateTime.parse(startTimeZone);
        DateTime date2 = DateTime.parse(endTimeZone);
        Duration diff1 = date1.difference(today);
        Duration diff2 = date1.difference(today);
        print(date1.day);

        meetingCollection.add(Meeting(

          from: today
              .add(Duration(hours: diff1.inHours)),
          to: today
              .add(Duration(hours: diff2.inHours)),
          background: _colorCollection[background],
          startTimeZone: '',
          endTimeZone: '',
          description: description,
          isAllDay: isAllDay,
          eventName: eventName,

        ));
      }

      setState(() {
        _events = DataSource(meetingCollection);
      });

  }
    getData();
    return meetingCollection;
}
/*
Future<List<Meeting>> getData() async {
  await Future.delayed(Duration(seconds: 3)); // 5초간 대기
  print("Fetched Data");

  final DateTime today = DateTime.now();
  final Random random = Random();

  List<Meeting> meetingCollection = <Meeting>[];

  calendar_counter =2;
  print("00000 되나");

  underuid.once().then((DataSnapshot snapshot) {
    calendar_counter = snapshot.value == null? 0 : snapshot.value['counter'];
    print(calendar_counter);
    print("11111counter가 되나");
  });

  await Future.delayed(Duration(seconds: 3)); // 5초간 대기

  List<String> keys = [];
  firebaseFirestore
      .collection("_keyList")
      .doc(uid!).get().then((DocumentSnapshot ds) {
    print(ds.get("keyname"));
    print("222222222_keyList 되나");
    keys = ds.get("keyname")?.cast<String>();
    print("33333333_keyList 되나");
    print(keys.isEmpty? null : keys.elementAt(0));
    print("44444444_keyList 되나");
  });
  await Future.delayed(Duration(seconds: 3)); // 5초간 대기

  print('5555555555');
  int from_days = 0;
  int from_hours = 0;
  int to_days = 0;
  int to_hours = 0;
  int background = 0;
  String startTimeZone = "";
  String endTimeZone = "";
  String description = "";
  String eventName = "";
  bool isAllDay = false;
  String key = "";

  print(calendar_counter);
  print("666666666666counter수");
  for (int i = 0; i < calendar_counter; i++) {
    print('77777777for문이 되나');
    key  = keys.elementAt(i);
    print('888888888이게 되나0');
    underuid.child(key).once().then((DataSnapshot snapshot) {
      print('9999999이게 되나1');
      startTimeZone = snapshot.value['StartDate'];
      print('101010101010이게 되나2');
      endTimeZone = snapshot.value['EndDate'];
      description = snapshot.value['notes'];
      eventName = snapshot.value['Subject'];
      isAllDay = snapshot.value['isAllDay'] == "false" ? false : true;
      background = snapshot.value['selectedColorIndex'];
      print('11 11 11 11이게되나 시작시간존');
      print(startTimeZone);
      print(endTimeZone);
      print(description);
      print(eventName);
      print(isAllDay);
      print(background);
    });
    await Future.delayed(Duration(seconds: 3)); // 5초간 대기
    print(background);

    meetingCollection.add(Meeting(

      from: today
          .add(Duration(days: 0 + i))
          .add(Duration(hours: 0 + i)),
      to: today
          .add(Duration(days: 0 + i))
          .add(Duration(hours: 3 + i)),
      background: _colorCollection[background],
      startTimeZone: startTimeZone,
      endTimeZone: endTimeZone,
      description: description,
      isAllDay: isAllDay,
      eventName: eventName,

    ));
  }

  await Future.delayed(Duration(seconds: 3)); // 5초간 대기

  return meetingCollection;*/
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
