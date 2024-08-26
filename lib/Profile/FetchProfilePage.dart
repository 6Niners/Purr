import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';

class FetchProfilePage extends StatefulWidget {
  @override
  _FetchProfilePageState createState() => _FetchProfilePageState();
}

class _FetchProfilePageState extends State<FetchProfilePage> {
  RegistrationController regController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    regController.getUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: Text("Profile"),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: _.userInfo.petName != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_.userInfo.avatarUrl),
                        radius: 50.0,
                      ),
                    ),
                    Divider(height: 60.0, color: Colors.blueGrey[600]),
                    Text(
                      "Pet Name",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _.userInfo.petName,
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Pet Type",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _.userInfo.petType,
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Breed",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _.userInfo.breed,
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Gender",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _.userInfo.gender,
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _.userInfo.email,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${_.userInfo.location.country}, ${_.userInfo.location.area}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                )
              : Container(
                  child: CircularProgressIndicator(),
                  padding: EdgeInsets.all(10),
                ),
        ),
      );
    });
  }
}
