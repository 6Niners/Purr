import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/Services/Database.dart';


class UserDataList extends StatefulWidget {
  @override
  _UserDataListState createState() => _UserDataListState();
}


class _UserDataListState extends State<UserDataList> {

  DatabaseService controller = Get.find();

  @override
  Widget build(BuildContext context) {

    controller.getUserProfileData();

    return GetBuilder<DatabaseService>( builder: (_) {

      return Padding(
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

            Text(_.profileData[2], style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Text("Pet", style: TextStyle(
              color: Colors.white,
            ),),

            SizedBox(height: 5.0),

            Text(_.profileData[1], style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Text("BREED", style: TextStyle(
              color: Colors.white,
            ),),

            SizedBox(height: 5.0),

            Text(_.profileData[0], style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Row(
              children: [
                Icon(Icons.email, color: Colors.white,),

                SizedBox(width: 10),

                Text("Email Placeholder", style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,

                ),)
              ],
            )
          ],
        ),
      )
    ;});
  }
}
