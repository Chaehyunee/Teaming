import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  var _isChecked = false;

  String _signupemailtext = "";
  String _pwtext = "";
  String _confpwtext = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset : false,
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
                border: Border.all(width: 1, color: Color(0xFF283593))),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("회원가입"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email',
                      hintText: 'user email',
                      border: OutlineInputBorder(),

                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? value) {
                      _signupemailtext = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: passwordController,
                    obscureText: true,
                    onSaved: (String? value) {
                      _pwtext = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ConfirmPassword',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: confirmController,
                    obscureText: true,
                    onSaved: (String? value) {
                      _confpwtext = value!;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }),
                        Text(
                          "이메일 수집에 동의하십니까?",
                        )
                      ],
                    ),
                  ),
                  SignInButtonBuilder(
                    text: "회원가입",
                    backgroundColor: Color(0xFF283593),
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _signupemailtext,
                            password: _pwtext
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        } /*else if (_pwtext != _confpwtext) {
                          print('The password unmatched ConfirmPassword.');
                        }*/
                      } catch (e) {
                        print(e);
                      }
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print('valid');
                      }
                      Navigator.pushNamed(context, '/mainPage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
