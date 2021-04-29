import 'package:flutter/material.dart';

void main(){
  runApp(Team_sel());
}

class Team_sel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.circle),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {

                  }
               );
              }
            )
          ],
        ),
      ),
    );
  }
}