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
int calendar_counter = 1;

// ignore: non_constant_identifier_names
Color _noti_color = Color(0xFF283593);
// ignore: non_constant_identifier_names
Color _state_color = Color(0xFF283593);


//final _TeamKey = GlobalKey<FormState>();

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

/*
  // ignore: close_sinks
  StreamController<String> streamController = StreamController<String>();
*/

  @override
  void initState() {
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

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 3)); // 5초간 대기
    print("Fetched Data");

    String keyvalue = "";
    dbRef.child(uid!).orderByChild('Subject').limitToFirst(2).once().then((DataSnapshot snapshot) {
      //dbRef.child(uid!).child('-May_PKNskL60IKDTfnn').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      _eventNameString = snapshot.value.toString();
      print(_eventNameString);
    });
    return "5초 기다렸다가 온 데이터입니다";
  }
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


          /* children:<Widget>[
             Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(//스트림, 빌더로 값 불러오기, 텍스트로 출력
                      stream: listTypeDb.child("mapTitle").onValue,
                      builder: (context, AsyncSnapshot<Event> snap){
                        if(!snap.hasData) return Text("로딩중");
                        return Column(
                          children: <Widget> [
                            Text(snap.data!.snapshot.value.runtimeType.toString()),
                            Text(snap.data!.snapshot.value.toString()),
                            Text(snap.data!.snapshot.value[0].toString()),
                          ],
                        );

                      }
                  )
                ],
              ),*/
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
        firebaseFirestore.collection('calendar_counter').doc('UID').set({
          "counter": calendar_counter++,
        });
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),//일정 편집 화면으로
        );
      }
    });
  }

  List<Meeting> getMeetingDetails() {//전체 코드 수정 필요
/*    String _eventNameString =  '';*/

    Stream.fromFuture(getData());

    final List<Meeting> meetingCollection = <Meeting>[];

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

    final DateTime today = DateTime.now();
    final Random random = Random();


    //for (int month = -1; month < 2; month++) {
    //  for (int day = -5; day < 5; day++) {
    //    for (int hour = 9; hour < 18; hour += 5) {
    meetingCollection.add(Meeting(

      from: today
          .add(Duration(days:  3))
          .add(Duration(hours: 2)),
      to: today
          .add(Duration(days:  3))
          .add(Duration(hours: 2 + 2)),
      background: _colorCollection[random.nextInt(9)],//목록 중 아무거나 하나 넣어줌
      startTimeZone:'',//_startDate.toIso8601String() ,
      endTimeZone: '',//_endDate.toIso8601String(),
      description: _eventNameString,
      isAllDay: false,
      eventName: _eventNameString,

    ));
    //  }
    // }
    // }

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
