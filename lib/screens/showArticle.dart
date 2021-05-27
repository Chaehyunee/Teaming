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
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        title: Text(
          "${Article.title}",
        ),
      ),
      body: ListView(
        children: [
          /*Container(
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
                style: TextStyle(fontSize: 23),
              ),
            ),
          ),*/
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.black),
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "작성자: ${Article.author}",
                      style: TextStyle(
                          fontSize: 17, fontFamily: 'NanumSquareRound'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "작성일자: ${Article.create.substring(0, 16)}",
                      style: TextStyle(
                          fontSize: 15, fontFamily: 'NanumSquareRound'),
                    ),
                  ],
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              //color: Theme.of(context).primaryColor,
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Text(
                "${Article.content}",
                style: TextStyle(fontSize: 17, fontFamily: 'NanumSquareRound'),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.black),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "댓글",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'NanumSquareRound',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
