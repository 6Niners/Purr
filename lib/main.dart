import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Chat/Chat_screen_UI.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Profile/FetchProfilePage.dart';
import 'package:purr/Registration/ChangePassword.dart';
import 'package:purr/Registration/MainRegistrationPage.dart';
import 'package:purr/Registration/SetupProfile.dart';
import 'package:purr/Registration/forgot_password.dart';
import 'package:purr/Registration/sign_in.dart';
import 'package:purr/Registration/sign_up.dart';
import 'package:purr/MainController.dart';
import 'package:purr/Registration/CommonClasses-functions.dart';
import 'package:purr/chat_list view.dart';


Future<void> main() async {

  runApp(MyApp());
  Get.put(MainController());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Purr',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
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
      appBar: AppBar(title: Text("Main Menu"), centerTitle: true,backgroundColor: Colors.blue,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PageButton(MainRegistrationPage(), "Main App Route"),
              PageButton(MainPage(), "Main Page!"),
              PageButton(LoginPage(), "Login Page!"),
              PageButton(SignUpPage(), "Sign Up Page"),
              PageButton(ForgotpasswordPage(), "Forgot password"),
              PageButton(ChangePasswordPage(), "Change Password"),
              PageButton(FetchProfilePage(), "Profile"),
              PageButton(SetupProfilePage(), "Setup Profile"),
              PageButton(ChatBox(), "chat"),
              PageButton(ChatPage(), "chat list"),

            ],
          ),
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

