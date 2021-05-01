import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:softpbl/Teaming/SideBarMenu.dart';

void main() {
  runApp(sign_up());
}

class sign_up extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeWidget()
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}
class _HomeWidgetState extends State<HomeWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            height: 450,
            width: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xFF283593)
                )
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "회원가입"
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ID',
                      hintText: 'userID',
                      border: OutlineInputBorder(),
                    ),
                    controller: idController,
                  ),
                  // Container(height: 10,),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ConfirmPassword',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: confirmController,
                    obscureText: true,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email',
                      hintText: 'user email',
                      border: OutlineInputBorder(),
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value;
                              });
                            }
                        ),
                        Text(
                          "이메일 수집에 동의하십니까",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  SignInButtonBuilder(
                    text: "회원가입",
                    backgroundColor: Color(0xFF283593),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}