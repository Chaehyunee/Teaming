import 'package:flutter/material.dart';
import 'MainPage.dart';

// ignore: camel_case_types
class themeSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
              ],
            ),
            body: Center(
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
            )));
  }
}

// ignore: camel_case_types
class themeSelect extends StatefulWidget {
  @override
  _themeSelectState createState() => _themeSelectState();
}

enum SelectTheme { theme1, theme2, theme3 }

// ignore: camel_case_types
class _themeSelectState extends State<themeSelect> {
  int _counter = 0;
  var _isChecked = false;
  SelectTheme _theme = SelectTheme.theme1;

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
            value: SelectTheme.theme1,
            groupValue: _theme,
            onChanged: (value) {
              setState(() {
                _theme = SelectTheme.theme1;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('두번째 테마'),
          leading: Radio(
            value: SelectTheme.theme2,
            groupValue: _theme,
            onChanged: (value) {
              setState(() {
                _theme = SelectTheme.theme2;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('세번째 테마'),
          leading: Radio(
            value: SelectTheme.theme3,
            groupValue: _theme,
            onChanged: (value) {
              setState(() {
                _theme = SelectTheme.theme3;
              });
            },
          ),
        ),
        ButtonTheme(
          minWidth: 120,
          height: 50,
          child: ElevatedButton(
            //ButtonTheme의 child로 버튼 위젯 삽입
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text(
              '테마 적용',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
