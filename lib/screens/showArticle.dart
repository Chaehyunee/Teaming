import 'package:flutter/material.dart';
import 'MainPage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ShowArticle extends StatefulWidget {
  @override
  _ShowArticleState createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).primaryColor,
              child: Text(
                "${Article.title}",
                style: TextStyle(fontSize: 25),
              )),
          Container(),
          Container()
        ],
      ),
    );
  }
}
