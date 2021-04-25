import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(side_menu());
}

class side_menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 75,
                width: 295,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                    ),
                    Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID:\n"),
                          Text("계정")
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle, size: 60,),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 295,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("회의 가능 시간:")
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 295,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("모임 가능한 장소: ")
                  ],
                ),
              ),
              Container(
                height: 330,
                width: 295,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: Colors.black
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("사용자 유형 팀명"),
                    Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("팀원이름")
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("팀원이름")
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("팀원이름")
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("팀원이름")
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
                    IconButton(
                      icon: Icon(Icons.calendar_today_rounded, size: 35,),
                      onPressed: () {
                        icon: Icon(Icons.circle);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications, size: 35, color: Colors.black,),
                    ),
                    IconButton(
                      icon: Icon(Icons.palette, size: 35, color: Colors.black,),
                    )
                  ],
                ),
              )
            ],
          )
        )
      ),

    );
  }
}