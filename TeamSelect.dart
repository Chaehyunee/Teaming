import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Team_sel());
}

class Team_sel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Team()
    );
  }
}

class Team extends StatefulWidget {
  @override
  _Team createState() => _Team();
}

class _Team extends State<Team> {
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
              onPressed: () {
                show_Team_sel();
              }
            ),
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }

  void show_Team_sel() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Color(0xFFEDEDED),
          content: Container(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  child: Container(
                    height: 50,
                    width: 250,
                    color: Color(0xFF9FA8DA),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF283593),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "그룹명 1",
                          style: TextStyle(
                            color: Colors.white
                          ),
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
                    height: 50,
                    width: 250,
                    color: Color(0xFF9FA8DA),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF283593),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "그룹명 2",
                          style: TextStyle(
                              color: Colors.white
                          ),
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
                    height: 50,
                    width: 250,
                    color: Color(0xFF9FA8DA),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF283593),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "그룹명 3",
                          style: TextStyle(
                              color: Colors.white
                          ),
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
                  onPressed: () {
                    create_Team();
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void create_Team() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Text("팀생성"),
          ),
        );
      }
    );
  }
}