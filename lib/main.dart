import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Registration/sign_in.dart';

import 'MainPage/Controller/Controller.dart';

void main() {
  runApp(MyApp());
  MainController cont=Get.put(MainController());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
      backgroundColor: Colors.black,
      appBar:AppBar(title: Text("pages list"),centerTitle: true,),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
        PageButton(MainPage(),"Main Page"),
        PageButton(LoginPage(title: 'Sign In'),"Login Page"),
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
  child: Text(text,style: TextStyle(color: Colors.black),),
    );
  }
}

