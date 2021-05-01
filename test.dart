import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _side_menu createState() => _side_menu();
}

class _side_menu extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Center(
          child: RaisedButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            onPressed: () {
              testAlert(context);
            },
            child: Text("PressMe"),
          ),
        ),
      ),
    );
  }

  void testAlert(BuildContext context) {
    var alert = AlertDialog(
      title: Text("Test"),
      content: Text("Done..!"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}