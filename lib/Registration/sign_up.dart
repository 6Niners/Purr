import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

class SignUpPage extends StatefulWidget {


  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {


  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextPassword=true;
  bool _obscureTextConfirmPassword=true;
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
                              child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
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
                                labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureTextPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureTextPassword = !_obscureTextPassword;
                                  });
                                },
                              ),


                          ),
                            obscureText: _obscureTextPassword,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                            validator: (input) {
                              if (input != _password.text) {
                                return "These passwords don't match";
                              }else{
                              return null;
                              }
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',

                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _obscureTextConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                                  });
                                },
                              ),
                            ),


                            obscureText: _obscureTextConfirmPassword,
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