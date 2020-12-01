import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Registration/RegistrationController.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegistrationController CONT=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the _LoginPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type an Email';
                        }
                        return null;
                      },
                      onChanged: (input) => {_email = input},
                      onSaved: (input) => {_email = input},
                      decoration: InputDecoration(
                          labelText: 'Email'
                      )
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Your password should be at least 6 characters';
                      }
                      return null;
                    },
                    onChanged: (input) => {_password = input},
                    onSaved: (input) => {_password = input},
                    decoration: InputDecoration(
                        labelText: 'Password'
                    ),
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      print("in");
                      await CONT.signIn(_formKey,_email,_password);
                    },
                    child: Text('Sign In'),
                  )
                ]
            )
        )
    );
  }





}