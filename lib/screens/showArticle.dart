import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginPage.dart';

class ShowArticle extends StatefulWidget {
  @override
  _ShowArticleState createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle> {
  final String colName = Article.id;

  final String fdAuthor = "author";
  final String fdContent = "content";
  final String fdCreate = "create";

  TextEditingController _newCommentCon = TextEditingController();

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
                fontSize: 18,
                fontFamily: 'NanumSquareRound',
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
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 90,
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'NanumSquareRound',
                        height: 1.0,
                      ),
                      autofocus: false,
                      controller: _newCommentCon,
                    ),
                  ),
                  Container(
                    height: 52,
                    child: ElevatedButton(
                      child: Text(
                        "댓글 등록",
                        style: TextStyle(fontFamily: 'NanumSquareRound'),
                      ),
                      onPressed: () {
                        if (_newCommentCon.text.isNotEmpty) {
                          createComment(_newCommentCon.text, UserData.userName);
                        }
                        _newCommentCon.clear();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();
                      },
                    ),
                  ),
                ],
              )),
          Container(
              height: 500,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(colName)
                    .orderBy(fdCreate, descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("댓글 로딩중...");
                    default:
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Timestamp ts = document[fdCreate];
                          String dt =
                              timestampToStrDateTime(ts).substring(0, 16);
                          return Container(
                              //elevation: 2,
                              child: Container(
                            padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                top: 10.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      document[fdAuthor],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      dt.toString(),
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    document[fdContent],
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ));
                        }).toList(),
                      );
                  }
                },
              )),
        ],
      ),
    );
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }

  void createComment(String content, String name) {
    FirebaseFirestore.instance.collection(colName).add({
      fdAuthor: name,
      fdContent: content,
      fdCreate: Timestamp.now(),
    });
  }
}
