import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void drawer() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
