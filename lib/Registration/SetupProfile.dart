import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/NewChat/chat.dart';
import 'package:purr/Profile/Avatar.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:path/path.dart';


class SetupProfilePage extends StatefulWidget {

  @override
  SetupProfilePageState createState() => SetupProfilePageState();
}

class SetupProfilePageState extends State<SetupProfilePage> {

  ChatBoxNew chat;
  TextEditingController _petName=TextEditingController();
  TextEditingController _pet=TextEditingController();
  TextEditingController _gender=TextEditingController();
  TextEditingController _breed=TextEditingController();
  String _avatarUrl;
  List<String> petTypes=["Dog","Cat","Hamster","Bird","Rabbit","Turtle","Other"];
  List<String> genders=["Male","Female"];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegistrationController regController = Get.find();


  @override
  void initState() {
    _gender.text=genders[0];
    _pet.text=petTypes[0];

    regController.getAddressFromLatLng();
    // TODO: implement initState
    super.initState();
  }
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
                              avatarUrl: _avatarUrl,
                              onTap: () async {
                                var image=await ImagePicker().getImage(source: ImageSource.gallery);
                                String fileName = basename(image.path);
                                StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
                                StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
                                StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
                                taskSnapshot.ref.getDownloadURL().then(
                                      (value) { print("Done: $value"); _avatarUrl=value;
                                      setState(() {

                                      });
                                      }
                                );

                              }),
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
                                      data: Get.theme.copyWith(canvasColor: Get.theme.highlightColor,),
                                      child: Center(
                                        child: DropdownButton(
                                          value: _pet.text,
                                          onChanged: (newValue) {
                                            _pet.text=newValue;
                                            setState(() {});
                                          },
                                          hint: Text("Please pick your pet type"),
                                          items: petTypes.map((location) {
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: 50,
                                    child: Text(
                                        'Pet Gender',
                                        style: Get.textTheme.bodyText1)
                                ),
                              ),
                              Theme(
                                data: Get.theme.copyWith(canvasColor: Get.theme.highlightColor,),
                                child: Center(
                                  child: DropdownButton(
                                    value: _gender.text,
                                    onChanged: (newValue) {
                                      _gender.text=newValue;
                                      setState(() {});
                                    },
                                    hint: Text("Please pick your pet Gender"),
                                    items: genders.map((location) {
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
                          regController.buildTextFormField(_petName, 'Pet Name', (input) {
                            if (input == '') {
                              return 'Please type a your pet name';
                            }
                            else{
                              return null;
                            }
                          },),

                          regController.buildTextFormField(_breed, 'Breed', (input) {
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
                                      await regController.updateUserData(ProfileData(petName:_petName.text, petType:_pet.text, breed:_breed.text,gender:_gender.text,avatarUrl: _avatarUrl, location: regController.userLocation));
                                      regController.getUsers();
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