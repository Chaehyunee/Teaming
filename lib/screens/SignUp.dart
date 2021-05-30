import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _TeamKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // 팀 생성 및 참가
  final TextEditingController NameController = TextEditingController();
  final TextEditingController expController = TextEditingController();

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
            height: 480,
            width: 300,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFF283593)),
                borderRadius: BorderRadius.circular(20)),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '이름',
                      hintText: '사용자 이름',
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
                      labelText: '이메일',
                      hintText: '사용자 이메일',
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
                      labelText: '비밀번호',
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
                      labelText: '비밀번호 확인',
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    controller: confirmController,
                    obscureText: true,
                    onChanged: (text) {
                      confirm = text;
                    },
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
                  ElevatedButton(
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
                          Navigator.pop(context);
                          create_Team();
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
                      child: Text("회원가입")),
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

  // 팀 생성 화면 출력 함수
  create_Team() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: 250,
                child: Form(
                    key: _TeamKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("팀을 새로 만드시겠습니까?"),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "팀명을 입력해 주세요.",
                                    border: OutlineInputBorder()),
                                controller: NameController,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "팀에 대한 설명을 입력해주세요.",
                                    border: OutlineInputBorder()),
                                controller: expController,
                              ),
                              SizedBox(height: 10),
                              RaisedButton(
                                  child: Text(
                                    "생성",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Color(0xFF283593),
                                  onPressed: () {
                                    int rng = Random().nextInt(50) + 1;
                                    firebaseFirestore
                                        .collection("Team")
                                        .doc(NameController.text)
                                        .set({
                                      "code": rng,
                                      "name": NameController.text,
                                      "explanation": expController.text,
                                      "member": [nameController.text]
                                    });
                                    firebaseFirestore
                                        .collection("Team")
                                        .doc("Team_List").update({
                                      "T_name": FieldValue.arrayUnion(<dynamic>[NameController.text])
                                    });
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        ),

                      ],
                    ))),
          );
        });
  }
}