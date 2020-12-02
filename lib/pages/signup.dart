// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'dart:async';
import 'package:PicBee1/pages/create_account.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();
  bool signUpButtonVisible =
      true; //for signing up the user, it displays circular loading while checking.

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  String username = '';

  //FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> register() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((user) {
      Fluttertoast.showToast(
        msg: 'Signed Up successful',
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CreateAccount(email: email.text, password: password.text);
      }));
    }).catchError((e) {
      //print(e);
      // code, message, details

      String message = 'Something went wrong';
      String error = '';
      error = e.code;
      if (error.contains('EMAIL_ALREADY_IN_USE')) {
        setState(() {
          message = 'Email already in use';
        });

        Fluttertoast.showToast(
          msg: '$message',
        );
      } else if (error.contains('INVALID_EMAIL')) {
        setState(() {
          message = 'Email is invalid';
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
        signUpButtonVisible = true;
      });
    });

    /* try{
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(email: email.text, password: password.text)) as FirebaseUser;

      Fluttertoast.showToast(
        msg: 'Signed Up successful',
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }
      )
      );


    } catch(signUpError) {
      if(signUpError is PlatformException) {

        Fluttertoast.showToast(
          msg: '${signUpError.code}',
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          timeInSecForIosWeb: 4,
        );
      }
    } */
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
          title: Text('Sign Up'),
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
                              "Create An Account",
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
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
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
                                  } else if (password.text != rePassword.text) {
                                    return 'Both passwords are not match';
                                  } else if (value.length < 6) {
                                    return 'Password minimum 6 characters';
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
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
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
                        Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: kIsWeb
                                  ? width
                                  : MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                controller: rePassword,
                                obscureText: true,
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter password again';
                                  } else if (password.text != rePassword.text) {
                                    return 'Both passwords are not match';
                                  } else if (value.length < 6) {
                                    return 'Password minimum 6 characters';
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
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.indigo,
                                    ),
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    hintText: "Re-enter password"),
                              ),
                            )),
                        SizedBox(height: 15.0),
                        signUpButtonVisible
                            ? SizedBox(
                                width: 140.0,
                                height: 40.0,
                                child: RaisedButton(
                                  child: Text(
                                    'Sign Up',
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
                                            signUpButtonVisible = false;
                                          });
                                          //Register user from here.
                                          Timer(Duration(milliseconds: 500),
                                              () {
                                            register();
                                          });
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
                                    Colors.indigo),
                              ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member?',
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
                                'Login',
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
