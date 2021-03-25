import 'package:demo_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkeys = GlobalKey<ScaffoldState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  _insertUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('username', 'suraj');
    sharedPreferences.setString('password', 'nepal123');
  }

  _checkUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('username') == _username.text &&
        sharedPreferences.getString('password') == _password.text) {
      final success = SnackBar(
        content: Text(
          'Successfully login',
          style: TextStyle(fontSize: 24.0),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,

      );
      _scaffoldkeys.currentState.showSnackBar(success);
      Timer(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    } else {
      final error = SnackBar(
        content: Text(
          'please try again',
          style: TextStyle(fontSize: 24.0),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      );
      _scaffoldkeys.currentState.showSnackBar(error);
    }
  }

  _usernameValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter Username';
    }
  }

  _passwordValidate(String value) {
    if (value.isEmpty) {
      return 'Please Enter password';
    }
  }

  _validate() {
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkeys,
        backgroundColor: Colors.white70,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) => _usernameValidate(value),
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) => _passwordValidate(value),
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(fontSize: 20.0)),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _insertUser();
                        _validate();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'login',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
