import 'package:flutter/material.dart';


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


      body: Padding(
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

            Text("Zezo", style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Text("PET TYPE", style: TextStyle(
              color: Colors.white,
            ),),

            SizedBox(height: 5.0),

            Text("Smol Fishark", style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Row(
              children: [
                Icon(Icons.email, color: Colors.white,),

                SizedBox(width: 10),

                Text("YoMommaCool@6Niners.co", style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,

                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}