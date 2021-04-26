import 'package:flutter/material.dart';

class themeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: (){
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
              ],
            ),

            body: Center (
                child: themeSelect(),
            ),

            // 드로워(서랍) 추가
            drawer: Drawer(
              // 리스트뷰 추가
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // 드로워해더 추가
                  DrawerHeader(
                    child: Text('Drawer Header'),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  // 리스트타일 추가
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // 네이게이터 팝을 통해 드로워를 닫는다.
                      Navigator.pop(context);
                    },
                  ),
                  // 리스트타일 추가
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {
                      // 드로워를 닫음
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
        )
    );
  }
}

class themeSelect extends StatefulWidget {
  @override
  _themeSelectState createState() => _themeSelectState();
}

enum Theme {theme1, theme2}

class _themeSelectState extends State<themeSelect> {
  int _counter = 0;
  var _isChecked = false;
  Theme _theme = Theme.theme1;

  void _increamentCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('첫번째 테마'),
          leading: Radio(
            value: Theme.theme1,
            groupValue: _theme,
            onChanged: (value) {
              setState(() {
                _theme = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('두번째 테마'),
          leading: Radio(
            value: Theme.theme2,
            groupValue: _theme,
            onChanged: (value) {
              setState(() {
                _theme = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

