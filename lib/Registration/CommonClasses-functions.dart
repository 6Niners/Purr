import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.black,fontSize: 18),
        subtitle1: TextStyle(color: Colors.blue,fontSize: 14)
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
    textTheme: TextTheme(
        headline6:  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.white,fontSize: 18),
        subtitle1: TextStyle(color: Colors.blue,fontSize: 14)
    ),
  );
}
class BoolToPassByReference extends GetxController{
  bool obscure=true;

}


String emailValidator(String email){
    if (!EmailValidator.validate(email)) {
      return 'Please type a valid Email';
    }
    return null;
}

String passwordValidator(String password){
  if(password.isEmpty){
    return 'Password Field empty';
  }else if(password.length < 6){
    return 'Password is Short';
  }
  return null;
}

class passwordMatchValidatorClass{
  TextEditingController otherpasswordController;
  passwordMatchValidatorClass(this.otherpasswordController);

  String passwordMatchValidator(String password) {
    if (password != otherpasswordController.text) {
      return "These passwords don't match";
    } else {
      return null;
    }
  }
}
