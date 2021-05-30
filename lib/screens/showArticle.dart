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
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
              color: Theme.of(context).primaryColor,
            ),
            padding: const EdgeInsets.only(
                left: 6.0, right: 6.0, top: 6.0, bottom: 6.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
              child: Text(
                "제목: ${Article.title}",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
            ),
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(right: 4.0, top: 4.0, bottom: 4.0),
              child: Text(
                "작성일자: ${Article.create}",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Text(
                "${Article.content}",
              ),
            ),
          )
        ],
      ),
    );
  }
}
