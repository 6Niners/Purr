import 'package:flutter/material.dart';



List<String> filteredDummyInfoList = ["Karim", "CoolDude", "Karim@6Niners.com"];

List<String> dummyInfoList = ["Friskie", "Sherazy", "Friskie@6Niners.com",
                              "Fanta", "Sherazy", "Fanta@6Niners.com",
                              "Arya", "Gay", "AmadeusGay@6Niners.com",
                              "Zezo", "SmallFishark", "Zuz@6Niners.com"];



List<String> returnProfileData(int counter) {

  for (int i = 0; i < 3; i++) {
    filteredDummyInfoList[i] = dummyInfoList[i + counter];
  }

  return filteredDummyInfoList;
}



class FetchProfilePage extends StatefulWidget {
  @override
  _FetchProfilePageState createState() => _FetchProfilePageState();
}

class _FetchProfilePageState extends State<FetchProfilePage> {

  int counter = -3;

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
          onPressed: (){
            setState(() {

              if (counter < 9){
                counter += 3;
              }
              else{
                counter = 0;
              }

              returnProfileData(counter);
            });
          },
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

            Text(filteredDummyInfoList[0], style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Text("PET TYPE", style: TextStyle(
              color: Colors.white,
            ),),

            SizedBox(height: 5.0),

            Text(filteredDummyInfoList[1], style: TextStyle(
              color: Colors.amberAccent[200],
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 30.0),

            Row(
              children: [
                Icon(Icons.email, color: Colors.white,),

                SizedBox(width: 10),

                Text(filteredDummyInfoList[2], style: TextStyle(
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