import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/CommonClasses-functions.dart';
import 'package:purr/Registration/RegistrationController.dart';

class ChangePasswordPage extends StatefulWidget {


  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _Currentpassword = TextEditingController();
  TextEditingController _Newpassword = TextEditingController();
  TextEditingController _NewpasswordConfirm = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BoolToPassByReference password_validated=BoolToPassByReference();

  BoolToPassByReference _obscureTextCurrentPassword=BoolToPassByReference();
  BoolToPassByReference _obscureTextNewPassword=BoolToPassByReference();
  BoolToPassByReference _obscureTextConfirmPassword=BoolToPassByReference();

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
                                child: Text(
                                  'Change Password',
                                  style: Get.theme.textTheme.headline6,
                                )),
                          ),
                          GetBuilder<RegistrationController>(
                              builder: (_) {
                                return _.buildTextFormFieldPassword(
                                    _Currentpassword, 'Current Password',
                                    _obscureTextCurrentPassword,Validator: (value) {
                                  if(password_validated.obscure){return null;}else{return "wrong password";}
                                },);
                              }
                          ),

                          GetBuilder<RegistrationController>(
                              builder: (_) {
                                return _.buildTextFormFieldPassword(
                                    _Newpassword, 'Password',
                                    _obscureTextNewPassword);
                              }
                          ),

                          GetBuilder<RegistrationController>(
                            builder: (_) {
                              return  _.buildTextFormFieldPassword(
                                  _NewpasswordConfirm, 'Confirm Password',
                                  _obscureTextConfirmPassword, Controller2:_Newpassword);

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
                                    password_validated.obscure=await CONT.validatePassword(_Currentpassword.text);
                                    setState(() {});
                                    if (_formKey.currentState.validate()&&password_validated.obscure) {
                                      await CONT.updatePassword(_Newpassword.text);
                                    }
                                  },
                                  child: Text('Sign Up',style: Get.theme.textTheme.bodyText1,),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ))),
    );
  }
}
