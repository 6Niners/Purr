import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

import 'package:purr/UI_Widgets.dart';

class VerfiyEmailPage extends StatefulWidget {
  VerfiyEmailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  VerfiyEmailPageState createState() => VerfiyEmailPageState();
}

class VerfiyEmailPageState extends State<VerfiyEmailPage> {
  int time;
  int count=1;
  Timer timer,timerforbutton;
  RegistrationController CONT=Get.find();
  @override
  void initState() {
    CONT.SendEmailVerification();
    timer=Timer.periodic(Duration(seconds: 5),(timer){
      CONT.ismailverified();
    }
    );
    setbuttontimer();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timerforbutton.cancel();
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

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
                      Center(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            child: Text("Verify Email",style: Get.theme.textTheme.headline6,)),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Text("Please click the link sent to "+CONT.firebaseUser.email+" to proceed",style:Get.theme.textTheme.headline6,)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            width: 150,
                            height: 70,

                            child: RaisedButton(
                                color: Get.theme.buttonColor,
                                onPressed: resendbutton(),
                                child: Text(buttontext(),style: Get.theme.textTheme.bodyText1)
                            ),
                          ),

                        ],
                      ),

                    ]
                ),
              ),
            ))
    );
  }
String buttontext(){
  if(time==0){
    return "Resend Mail";
  }else{
    return time.toString();
  }
}
setbuttontimer(){
  time=60*count;
  timerforbutton= new Timer.periodic(Duration(seconds: 1),(timer){
    if(time==0){
      timerforbutton.cancel();

    }else{
      setState(() {time--;
      });
    }
  }
  );
}
resendbutton() {
  //print("in");
  if(time==0){
  if (count <= 3) {
    return ()
    {
    CONT.SendEmailVerification();
    count++;
    timerforbutton.cancel();
    setbuttontimer();
    };

  }
  else {
    ShowToast("too much email requests sent, please check your email",
        Background_color: Colors.red);
    return null;
  }

}else{return null;}
  }
}



