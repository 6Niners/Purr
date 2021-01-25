import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/CommonClasses-functions.dart';
import 'package:purr/Registration/RegistrationController.dart';

class ChangePasswordPage extends StatefulWidget {


  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _newPasswordConfirm = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BoolToPassByReference passwordValidated=BoolToPassByReference();

  BoolToPassByReference _obscureTextCurrentPassword=BoolToPassByReference();
  BoolToPassByReference _obscureTextNewPassword=BoolToPassByReference();
  BoolToPassByReference _obscureTextConfirmPassword=BoolToPassByReference();

  RegistrationController controller = Get.find();
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
                                    _currentPassword, 'Current Password',
                                    _obscureTextCurrentPassword,Validator: (value) {
                                  if(passwordValidated.obscure){return null;}else{return "wrong password";}
                                },);
                              }
                          ),

                          GetBuilder<RegistrationController>(
                              builder: (_) {
                                return _.buildTextFormFieldPassword(
                                    _newPassword, 'Password',
                                    _obscureTextNewPassword);
                              }
                          ),

                          GetBuilder<RegistrationController>(
                            builder: (_) {
                              return  _.buildTextFormFieldPassword(
                                  _newPasswordConfirm, 'Confirm Password',
                                  _obscureTextConfirmPassword, Controller2:_newPassword);

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
                                    passwordValidated.obscure=await controller.validatePassword(_currentPassword.text);
                                    setState(() {});
                                    if (_formKey.currentState.validate()&&passwordValidated.obscure) {
                                      await controller.updatePassword(_newPassword.text);
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
