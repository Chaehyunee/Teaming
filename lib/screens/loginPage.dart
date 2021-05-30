import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserData {
  static late String userName;
  static late String userEmail;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String _Emailfieldtext = "";
  String _PWfieldtext = "";

  String name = "";
  String email = "";
  String url = "";

  void inputData() {
    final User user = auth.currentUser!;
    UserData.userName = user.displayName!;
    UserData.userEmail = user.email!;
  }

  Future<String> googleSingIn() async {
    final GoogleSignInAccount account = (await googleSignIn.signIn())!;
    final GoogleSignInAuthentication googleAuth = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User user = authResult.user!;

    assert(!user.isAnonymous);

    assert(user.uid == auth.currentUser!.uid);

    setState(() {
      email = user.email!;
      url = user.photoURL!;
      name = user.displayName!;
    });

    inputData();

    Navigator.pushNamed(context, '/mainPage');
    return '구글 로그인 성공: $user';
  }

  void googleSignOut() async {
    await auth.signOut();
    await googleSignIn.signOut();

    setState(() {
      email = "";
      url = "";
      name = "";
    });

    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/teaming_logo.png', scale: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    //해당 부분은 email의 유무에 따라 로그인이 됐는지 안됐는지를 판단하고 해당 로그인이 제대로 됐다면
                    //구글의 프로필 이미지, 닉네임, 이메일을 가져와 출력을 시켜줄것이다.
                    email == ""
                        ? Container()
                        : Column(
                            children: <Widget>[
                              //Image.network(url),
                              Text(name),
                              Text(email),
                            ],
                          ),
                    /*RaisedButton(
                      onPressed: () {
                        //여기또한 이메일의 존재 여부를 통해 해당 버튼의 기능을 바꾸게 된다.
                        if (email == "") {
                          googleSingIn();
                        } else {
                          googleSignOut();
                        }
                      },
                      //여기또한 이메일의 존재 여부를 통해 해당 버튼의 텍스트를 바꾸어 준다.
                      child: Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.subdirectory_arrow_right),
                              Text(email == "" ? 'Google Login' : "Google Logout")
                            ],
                          )),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text('Naver',
                              style: TextStyle(color: Colors.white)),
                          //color: Colors.green[700],
                          onPressed: () {
                            //화면 연결 to 네이버 로그인 창
                          },
                        ),
                        ElevatedButton(
                            child: Text('Kakao',
                                style: TextStyle(color: Colors.white)),
                            //color: Colors.amber[700],
                            onPressed: () {} //화면 연결 to 카카오톡 로그인 창
                            ),
                        ElevatedButton(
                          child: Text(
                            'Google',
                            style: TextStyle(color: Colors.white),
                          ),
                          //color: Colors.red[800],
                          onPressed: () {
                            googleSingIn();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 250,
                          height: 140,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Flexible(
                                  child: new TextField(
                                decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    border: OutlineInputBorder()),
                                onChanged: (text) {
                                  setState(() {
                                    _Emailfieldtext = text;
                                  });
                                },
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              new Flexible(
                                child: new TextField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: '비밀번호',
                                      border: OutlineInputBorder()),
                                  onChanged: (text) {
                                    setState(() {
                                      _PWfieldtext = text;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonTheme(
                            minWidth: 5.0,
                            height: 120.0,
                            child: RaisedButton(
                              child: Text('Login',
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xFF283593),
                              onPressed: () async {
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: _Emailfieldtext,
                                              password: _PWfieldtext);
                                  Navigator.pushNamed(context, '/mainPage');
                                  inputData();
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonTheme(
                            minWidth: 120.0,
                            height: 40.0,
                            child: RaisedButton(
                              child: Text('회원가입',
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xFF283593),
                              onPressed: () {
                                //화면 연결 to 회원가입 창
                                Navigator.pushNamed(context, '/signup');
                              },
                            )),
                        ButtonTheme(
                            minWidth: 120.0,
                            height: 40.0,
                            child: RaisedButton(
                              child: Text('E-mail/PW 찾기',
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xFF283593),
                              onPressed: () {
                                //화면 연결 to E-mail/PW 찾기 창
                              },
                            ))
                      ],
                    )
                  ]),
            )));
  }
}
