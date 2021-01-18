import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/NewChat/chat.dart';
import 'package:purr/Profile/Avatar.dart';
import 'package:purr/Registration/RegistrationController.dart';

import 'RegistrationController.dart';


class SetupProfilePage extends StatefulWidget {

  @override
  SetupProfilePageState createState() => SetupProfilePageState();
}

class SetupProfilePageState extends State<SetupProfilePage> {

  ChatBoxNew chat;
  TextEditingController _petName=TextEditingController();
  TextEditingController _pet=TextEditingController();
  TextEditingController _breed=TextEditingController();
  String _avatarUrl;
  List<String> PetTypes=["Dog","Cat","Hamster","Bird","Rabbit","Turtle","Other"];
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
                child: SingleChildScrollView(
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Avatar(
                              avatarUrl: REGCONT.UserInfo.avatarUrl,
                              onTap: () async {
                                await ImagePicker().getImage(source: ImageSource.gallery);

                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: 50,
                                          child: Text(
                                            'Pet Type',
                                            style: Get.textTheme.bodyText1)
                                      ),
                                    ),
                                    Theme(
                                      data: Get.theme.copyWith(canvasColor: Colors.black,),
                                      child: Center(
                                        child: DropdownButton(
                                          value: _pet.text!=""?_pet.text:PetTypes[0],
                                          onChanged: (newValue) {
                                            _pet.text=newValue;
                                            setState(() {});
                                          },
                                          hint: Text("Please pick your pet type"),
                                          items: PetTypes.map((location) {
                                            return DropdownMenuItem(
                                              child: new Text(location, style: Get.textTheme.bodyText1),
                                              value: location,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          REGCONT.buildTextFormField(_petName, 'Pet Name', (input) {
                            if (input == '') {
                              return 'Please type a your pet name';
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
                                      REGCONT.GetUsers();
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
                ),
              )
          )
      ),
    );
  }





}