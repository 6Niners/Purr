import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:purr/Registration/forgot_password.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextPassword=true;
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
                              return null;
                            },
                            controller: _email,
                            style: TextStyle(fontSize: 20),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            return null;
                          },
                          controller: _password,
                          style: TextStyle(fontSize: 20),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgotpasswordPage(title: 'Forgot password'));
                          },
                          child: new Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.blue),
                          ),
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
                                  await CONT.signIn(_email.text,_password.text);}
                              },
                              child: Text('Sign In',style: TextStyle(fontSize: 20,)),
                            ),
                          ),

                        ],
                      ),

                    ]
                ),
              ),
            )
        ))
    );
  }





}