import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {


  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegistrationController CONT=Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wallpaper-cat.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  color: Colors.grey[100],
                  elevation: 30,

                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child: Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                              validator: (input) {
                                if (!EmailValidator.validate(input)) {
                                  return 'Please type a valid Email';
                                }
                                else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _email,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  labelText: 'Email'
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Your password should be at least 6 characters';
                              }
                              else{
                                return null;
                              }
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _password,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                labelText: 'Password'
                            ),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (input) {
                              if (input != _password.text) {
                                return "Those passwords didn't match";
                              }else{
                              return null;
                              }
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                labelText: 'Confirm Password'
                            ),
                            obscureText: true,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              width: 150,
                              height: 70,

                              child: RaisedButton(
                                color: Colors.grey,
                                onPressed: () async {
                                  Get.back();
                                },
                                child: Text('Back'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              width: 150,
                              height: 70,

                              child: RaisedButton(
                                color: Colors.blue,

                                onPressed: () async {
                                  //print("in");
                                  if (_formKey.currentState.validate()) {
                                    await CONT.signUp(_email.text,_password.text);}
                                },
                                child: Text('Sign Up'),
                              ),
                            )
                          ],
                        ),
                      ]
                  ),
                ),
              )
          )
      ),
    );
  }





}