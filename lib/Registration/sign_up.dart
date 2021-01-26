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
  TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BoolToPassByReference _obscureTextPassword = BoolToPassByReference();
  BoolToPassByReference _obscureTextConfirmPassword = BoolToPassByReference();
  RegistrationController regController = Get.find();

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
                          regController.buildTextFormField(
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
                                      _confirmPassword, 'Confirm Password',
                                      _obscureTextConfirmPassword, textController2:_password);

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
                                  color: Get.theme.canvasColor,
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),

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
                                  color: Get.theme.buttonColor,
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),

                                  onPressed: () async {
                                    //print("in");
                                    if (_formKey.currentState.validate()) {
                                      await regController.signUp(
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