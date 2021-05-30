import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _isChecked = false;

  String name = "";
  String email = "";
  String password = "";
  String confirm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
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
                      labelText: 'name',
                      hintText: 'user name',
                      border: OutlineInputBorder(),
                    ),
                    controller: nameController,
                    onChanged: (text) {
                      name = text;
                    },
                  ),
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
                    onChanged: (text) {
                      email = text;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: passwordController,
                    obscureText: true,
                    onChanged: (text) {
                      password = text;
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
                    onChanged: (text) {
                      confirm = text;
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
                      //if (!_formKey.currentState.validate()) return;
                      if (passwordController.text != confirmController.text) {
                        //toastError(_scaffoldKey, PlatformException(code: 'signup', message: '비밀번호를 확인해주세요'));
                        return;
                      }
                      try {
                        final r = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        User user = r.user!;
                        await user.updateProfile(
                            displayName: nameController.text);
                      } catch (e) {}
                      /*try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }*/
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
/*
  toastError(GlobalKey<ScaffoldState> key, dynamic e) {
    String message = 'unknown error';
    if (e is PlatformException) message = e.message;
    final snackBar = SnackBar(content: Text(message));
    key.currentState.showSnackBar(snackbar);
  }*/
}