import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purr/MainPage/MainPage.dart';

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
                  ),
                  RaisedButton(
                    onPressed: () async {
                      print("in");
                      await signIn();
                    },
                    child: Text('Sign In'),
                  )
                ]
            )
        )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    print(formState.validate());
    if (!formState.validate()) {
      print("gfiooufihg");
      formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        //FirebaseUser user = FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

/*Future<void> signIn() async {

    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      //FirebaseUser user = FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));

        }
      }
    }*/

}