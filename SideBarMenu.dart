import 'package:flutter/material.dart';

void main() {
  runApp(side_menu());
}

class side_menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       appBar: AppBar(
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.menu),
             onPressed: () {},
           ),
         ],
        ),
        drawer: Drawer(

        ),
      ),
    );
  }
}