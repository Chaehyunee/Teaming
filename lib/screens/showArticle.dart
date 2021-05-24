import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowArticle extends StatefulWidget {
  @override
  _ShowArticleState createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle> {
  final String colName = "article";

  final String fdAuthor = "author";
  final String fdTitle = "title";
  final String fdContent = "content";
  final String fdCreate = "create";

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
