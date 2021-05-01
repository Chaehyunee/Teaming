import 'package:flutter/material.dart';

void main(){
  runApp(Team_sel());
}

class Team_sel extends StatefulWidget {
  _Team_sel createState() => _Team_sel();
}

class _Team_sel extends State<Team_sel> {
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
                showDialog(
                  context: context,
                  barrierDismissible: false,

                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
