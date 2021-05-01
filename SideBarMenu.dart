import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(side_menu());
}

class side_menu extends StatefulWidget{
  @override
  _side_menu createState() => _side_menu();
}

class _side_menu extends State<side_menu>{
  var _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Color(0xFF283593)),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.circle),
              onPressed: () {},
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
                    Container(
                      height: 50,
                      width: 50,
                      child:
                      IconButton(
                        icon: Icon(Icons.remove_circle,size: 50, color: Color(0xFF283593)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 265,
                color: Color(0xFF9FA8DA),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "회의 가능 시간:",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 265,
                color: Color(0xFF9FA8DA),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "모임 가능한 장소: ",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 330,
                width: 265,
                color: Color(0xFFEDEDED),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("사용자 유형 팀명"),
                    Container(
                      height: 40,
                      width: 200,
                      color: Color(0xFF9FA8DA),
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
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      color: Color(0xFF9FA8DA),
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
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      color: Color(0xFF9FA8DA),
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
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      color: Color(0xFF9FA8DA),
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
                            style: TextStyle(
                                color: Colors.white
                            ),
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
                            Icon(
                              Icons.circle,
                              color: Color(0xFF283593),
                              size: 40,
                            ),
                            Text(
                              "월/주",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Color(0xFF283593),
                      ),
                      onPressed: () {
                        setState(() {
                        });
                      }
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.palette,
                        size: 40,
                        color:Color(0xFF283593)
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
