import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Registration/forgot_password.dart';
import 'package:purr/Registration/sign_in.dart';
import 'package:purr/Registration/sign_up.dart';

import 'MainController.dart';
import 'package:purr/Registration/ChangePassword.dart';


void main() {
  runApp(MyApp());
  Get.put(MainController());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MainPage(),
      //home: LoginPage(title: 'Sign In'),
      home:ListOfPages(),
    );
  }
}

class ListOfPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(title: Text("Main Menu"),centerTitle: true,),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        PageButton(MainPage(),"Main Page"),
        PageButton(LoginPage(title: 'Sign In'),"Login Page"),
        PageButton(SignUpPage(title: 'Sign Up'),"Sign Up Page"),
        PageButton(ForgotpasswordPage(title: 'Forgot password'),"Forgot password"),
        PageButton(ChangePasswordPage(title: 'Change Password'),"Change Password"),
        PageButton(MainPage(), "Profile"),

          ],
        ),
      ),
    );
  }

  FlatButton PageButton(var page,String text) {
    return FlatButton(

    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
  onPressed: (){Get.to(page); },
  color:Colors.grey[800],
  child: Text(text,style: TextStyle(color: Colors.white),),);
  }
}

