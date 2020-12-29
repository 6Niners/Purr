import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/Services/Database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purr/Profile/UserDataList.dart';


class FetchProfilePage extends StatefulWidget {
  @override
  _FetchProfilePageState createState() => _FetchProfilePageState();
}



class _FetchProfilePageState extends State<FetchProfilePage> {

  @override
  Widget build(BuildContext context) {

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


      body: UserDataList(),
    );
  }
}