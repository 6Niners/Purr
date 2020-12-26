import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:purr/Models/ProfileData.dart';

class UserDataList extends StatefulWidget {
  @override
  _UserDataListState createState() => _UserDataListState();
}


class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {

    final profileData = Provider.of<List<ProfileData>>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/Profile/Images/cat_avatar.jpg"),
              radius: 50.0,
            ),
          ),

          Divider(height: 60.0, color: Colors.blueGrey[600]),

          Text("NAME", style: TextStyle(
            color: Colors.white,
          ),),

          SizedBox(height: 5.0),

          Text(profileData[1].petName, style: TextStyle(
            color: Colors.amberAccent[200],
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),),

          SizedBox(height: 30.0),

          Text("PET", style: TextStyle(
            color: Colors.white,
          ),),

          SizedBox(height: 5.0),

          Text(profileData[1].pet, style: TextStyle(
            color: Colors.amberAccent[200],
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),),

          SizedBox(height: 30.0),

          Text("BREED", style: TextStyle(
            color: Colors.white,
          ),),

          SizedBox(height: 5.0),

          Text(profileData[1].breed, style: TextStyle(
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
    );
  }
}
