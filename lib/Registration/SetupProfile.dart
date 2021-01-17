import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Models/ProfileData.dart';

import 'RegistrationController.dart';

class SetupProfilePage extends StatefulWidget {

  @override
  SetupProfilePageState createState() => SetupProfilePageState();
}

class SetupProfilePageState extends State<SetupProfilePage> {


  TextEditingController _petName=TextEditingController();
  TextEditingController _pet=TextEditingController();
  TextEditingController _breed=TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegistrationController REGCONT = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wallpaper-cat.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _formKey,
              child: Center(
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
                              child: Text("Setup Profile",style: Get.theme.textTheme.headline6,),)),
                        REGCONT.buildTextFormField(_petName, 'Pet Name', (input) {
                          if (input == '') {
                            return 'Please type a your pet name';
                          }
                          else{
                            return null;
                          }
                        },),

                        REGCONT.buildTextFormField(_pet, 'Pet', (input) {
                          if (input == '') {
                            return 'Please your pet type';
                          }
                          else{
                            return null;
                          }
                        },),
                        REGCONT.buildTextFormField(_breed, 'Breed', (input) {
                          if (input == '') {
                            return 'Please your pet breed';
                          }
                          else{
                            return null;
                          }
                        },),
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
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
                                onPressed: () async {
                                  //print("in");
                                  if (_formKey.currentState.validate()) {
                                    await REGCONT.updateUserData(ProfileData(petName:_petName.text, petType:_pet.text, breed:_breed.text));
                                    Get.offAll(MainPage());
                                  }
                                },
                                child: Text('Next',style:Get.theme.textTheme.bodyText1),
                              ),
                            )
                          ],
                        ),
                      ]
                  ),
                ),
              )
          )
      ),
    );
  }





}