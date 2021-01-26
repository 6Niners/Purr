import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:purr/Registration/sign_in.dart';
import 'package:purr/Registration/sign_up.dart';

class MainRegistrationPage extends StatefulWidget {

  @override
  MainRegistrationPageState createState() => MainRegistrationPageState();
}

class MainRegistrationPageState extends State<MainRegistrationPage> {




  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RegistrationController regController=Get.find();
      regController.checkIfLoggedIn();
    });
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/wallpaper-cat.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Card(
                color: Get.theme.backgroundColor,
                elevation: 30,

                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        width: 150,
                        height: 70,
                        child: RaisedButton(
                          color: Get.theme.canvasColor,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),

                          onPressed: () {
                            Get.to(SignUpPage());
                          },
                          child: Text('Sign up',style: Get.theme.textTheme.bodyText1,),
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

                          onPressed: () {
                            //print("in");
                            Get.to(LoginPage());
                          },
                          child: Text('Sign In',style: Get.theme.textTheme.bodyText1,),
                        ),
                      ),
                    ]
                ),
              ),
            ))
    );
  }





}