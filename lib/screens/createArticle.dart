import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginPage.dart';

class CreateArticle extends StatefulWidget {
  @override
  _CreateArticleState createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  final String colName = "article";

  final String fdAuthor = "author";
  final String fdTitle = "title";
  final String fdContent = "content";
  final String fdCreate = "create";

  TextEditingController _newTitleCon = TextEditingController();
  TextEditingController _newContentCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text("게시글 작성"),
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 15.0, left: 15.0),
                  child: Text(
                    "게시글 제목",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  width: 380,
                  child: TextField(
                    autofocus: false,
                    controller: _newTitleCon,
                    maxLines: 1,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 15.0, left: 15.0),
                  child: Text(
                    "게시글 내용",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  width: 380,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    autofocus: false,
                    controller: _newContentCon,
                    maxLines: 10,
                  ),
                ),
                ElevatedButton(
                    child: Text("게시글 등록"),
                    onPressed: () {
                      if (_newTitleCon.text.isNotEmpty &&
                          _newContentCon.text.isNotEmpty) {
                        createDoc(_newTitleCon.text, _newContentCon.text,
                            UserData.userName);
                      }
                      _newTitleCon.clear();
                      _newContentCon.clear();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void createDoc(String title, String content, String name) {
    FirebaseFirestore.instance.collection(colName).add({
      fdAuthor: name,
      fdTitle: title,
      fdContent: content,
      fdCreate: Timestamp.now(),
    });
  }
}
