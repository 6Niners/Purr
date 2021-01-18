import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    //go to more actions button
    buttonColor: Colors.blue[400],
    //label in text field
    // set the primaryColor light theme or accentColor for dark theme.
    primaryColor: Colors.blue[800],
    //border color
    highlightColor: Colors.blue[800],
    //back button
    canvasColor: Colors.blue[100],
    //message sent by
    focusColor: Colors.blue[800],
    //message sent to me
    cardColor: Colors.grey[100],
    //meeasge comboser
    cursorColor: Colors.blue[900],
    // set the primaryColor light theme or accentColor for dark theme.
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.black,fontSize: 18),
        subtitle1: TextStyle(color: Colors.blue,fontSize: 14),
        bodyText2: TextStyle(color: Colors.white,fontSize: 14),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.blueGrey[900],
    //go to more actions button
    buttonColor: Colors.green[800],
    //back button
    primaryColor: Colors.black45,
    //back button
    canvasColor: Colors.black45,
    //border color
    highlightColor: Colors.green[800],
    //label in text field and border
    // set the primaryColor light theme or accentColor for dark theme.
    accentColor: Colors.green[800],

    //message sent by
    focusColor: Colors.purple,
    //message sent to me
    cardColor: Colors.grey[800],
    //meeasge comboser
    cursorColor: Colors.blue[900],

    textTheme: TextTheme(
        headline6:  TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
        bodyText1: TextStyle(color: Colors.white,fontSize: 18),
        subtitle1: TextStyle(color: Colors.blue,fontSize: 14),
      bodyText2: TextStyle(color: Colors.white,fontSize: 14),
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
