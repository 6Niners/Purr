import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        return 'Ok';
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                          labelText: 'Email'
                      )
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Your password should be atleast 6 characters';
                      }
                      return 'Ok';
                    },
                    onSaved: (input) => {_password = input},
                    decoration: InputDecoration(
                        labelText: 'Password'
                    ),
                    obscureText: true,
                  )
                ]
              //TODO: implement widget
            )
        )
    );
  }
}
