
import 'package:PicBee1/global_variable.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _formKey = GlobalKey<FormState>();
  bool signInButtonVisible =
  true; //for signing in the user, it displays circular loading while checking.

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  loginUser() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email.text, password: password.text)
        .then((user) {

          setState(() {
            GlobalVariable.isAuth = true;
          });

          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return Home();
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
      setState(() {
        signInButtonVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = 0.0;

    setState(() {
      width = MediaQuery.of(context).size.width / 2;
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Sign In'),
          centerTitle: true,
          //centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: Stack(children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18.0),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
                  alignment: Alignment.center,
                  height: 550,
                  width: 320,
                  child: ListView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 7, 3, 0),
                            child: Text(
                              "Sign in with your account",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 19,
                              ),
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? width
                                  : MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: email,
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Email address';
                                  } else {
                                    bool isValid =
                                    EmailValidator.validate(value);

                                    if (isValid == false) {
                                      return 'Email address is invalid!';
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide:
                                        BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide: BorderSide(
                                          color: Colors.indigo,)),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.indigo,
                                    ),
                                    hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                    hintText: "Enter an email"),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? width
                                  : MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide:
                                        BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide: BorderSide(
                                            color:  Colors.indigo)),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.indigo,
                                    ),
                                    hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                    hintText: "Enter password"),
                              ),
                            )),

                        SizedBox(height: 15.0),
                        signInButtonVisible
                            ? SizedBox(
                          width: 140.0,
                          height: 40.0,
                          child: RaisedButton(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                            color: Colors.indigo,
                            splashColor: Colors.blue,
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  if (email.text.contains('gmail.com')) {
                                    setState(() {
                                      signInButtonVisible = false;
                                    });

                                    loginUser();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Email format is incorrect');
                                  }
                                }
                              });
                            },
                          ),
                        )
                            : CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.indigo,),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a member?',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ]),
                ),
              )
            ])));
  }
}
