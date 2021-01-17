import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/Registration/RegistrationController.dart';



class FetchProfilePage extends StatefulWidget {
  @override
  _FetchProfilePageState createState() => _FetchProfilePageState();
}



class _FetchProfilePageState extends State<FetchProfilePage> {

  RegistrationController REGCONT = Get.find();

  @override
  Widget build(BuildContext context) {

    REGCONT.getUserProfileData();

    return GetBuilder<RegistrationController>( builder: (_) {

      return Scaffold(

        backgroundColor: Colors.blueGrey[900],

        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: Text("Profile"),
          elevation: 0.0,
        ),


        floatingActionButton: FloatingActionButton.extended(
            label: Text("Update"),
            icon: Icon(Icons.wifi_protected_setup),
            backgroundColor: Colors.blueGrey[800],
            onPressed: (){},
        ),


        body: Padding (
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/Profile/Images/cat_avatar.jpg"),
                  radius: 50.0,
                ),
              ),

              Divider(height: 60.0, color: Colors.blueGrey[600]),

              Text("NAME", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.UserInfo.petName, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),

              Text("PetType", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.UserInfo.petType, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),

              Text("BREED", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.UserInfo.breed, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),

              Row(
                children: [
                  Icon(Icons.email, color: Colors.white,),

                  SizedBox(width: 10),

                  Text(_.userEmail, style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,

                  ),)
                ],
              )
            ],
          ),
        ),
      )
    ;});
  }
}