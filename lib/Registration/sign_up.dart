import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:purr/Registration/CommonClasses-functions.dart';

class SignUpPage extends StatefulWidget {


  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {


  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BoolToPassByReference _obscureTextPassword = BoolToPassByReference();
  BoolToPassByReference _obscureTextConfirmPassword = BoolToPassByReference();
  RegistrationController CONT = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wallpaper-cat.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _formKey,
              child: Center(
                child: Card(
                  color: Get.theme.backgroundColor,
                  elevation: 30,

                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(5),
                                child: Text("Sign Up",style: Get.theme.textTheme.headline6,)),
                          ),
                          CONT.buildTextFormField(
                                  _email,
                                  "Email",
                                  emailValidator
                              ),
                          GetBuilder<RegistrationController>(
                              builder: (_) {
                                return _.buildTextFormFieldPassword(
                                    _password, 'Password',
                                    _obscureTextPassword);
                              }
                            ),

                          GetBuilder<RegistrationController>(
                              builder: (_) {
                                return  _.buildTextFormFieldPassword(
                                      _confirmpassword, 'Confirm Password',
                                      _obscureTextConfirmPassword, Controller2:_password);

                              },

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
                                  child: Text('Back',style: Get.theme.textTheme.bodyText1,),
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
                                      await CONT.signUp(
                                          _email.text, _password.text);
                                    }
                                  },
                                  child: Text('Sign Up',style: Get.theme.textTheme.bodyText1,),
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              )
          )
      ),
    );
  }


}