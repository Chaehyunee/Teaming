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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Icon(Icons.menu),
      ),
      body: _buildBody()
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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
              SignInButtonBuilder(
                text: 'Sign Up',
                icon: Icons.email,
                backgroundColor: Colors.blueGrey,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
