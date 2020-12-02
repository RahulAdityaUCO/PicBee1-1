import 'dart:async';

import 'package:PicBee1/global_variable.dart';
import 'package:PicBee1/pages/home.dart';
import 'package:PicBee1/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccount extends StatefulWidget {
  String email, password;
  CreateAccount({Key key, this.email, this.password}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $username!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        loginUser();

        //Navigator.pop(context, username);
      });
    }
  }

  loginUser() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: widget.email, password: widget.password)
        .then((user) {
      setState(() {
        GlobalVariable.isAuth = true;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Home(
          username: username,
        );
      }));
    }).catchError((e) {
      //print(e);
      // code, message, details

      String message = 'Something went wrong';
      String error = '';
      error = e.code;
      if (error.contains('ERROR_WRONG_PASS')) {
        setState(() {
          message = 'Email or Password is incorrect';
        });

        Fluttertoast.showToast(
          msg: '$message',
        );
      } else {
        Fluttertoast.showToast(
          msg: '$e',
        );
      }
    });
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context,
          titleText: "Set up your profile", removeBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Create a username",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().length < 3 || val.isEmpty) {
                            return "Username too short";
                          } else if (val.trim().length > 12) {
                            return "Username too long";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
