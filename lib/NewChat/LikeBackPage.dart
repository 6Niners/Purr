import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/NewChat/chat.dart';
import 'package:purr/Registration/RegistrationController.dart';



class LikeBackPage extends StatefulWidget {
  final String uid;
  @override
  _LikeBackPageState createState() => _LikeBackPageState();

  LikeBackPage(this.uid);
}



class _LikeBackPageState extends State<LikeBackPage> {

  RegistrationController regController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    regController.getUserProfileLikeBack(widget.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return GetBuilder<RegistrationController>( builder: (_) {

      return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: Text("Like Back"),
          elevation: 0.0,
        ),


        body: Padding (
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),

          child: _.likeBackData.petName!=null?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_.userInfo.avatarUrl),
                  radius: 50.0,
                ),
              ),

              Divider(height: 60.0, color: Colors.blueGrey[600]),

              Text("Pet Name", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.likeBackData.petName, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),

              Text("Pet Type", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.likeBackData.petType, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),

              Text("Breed", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.likeBackData.breed, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),
              Text("Gender", style: TextStyle(
                color: Colors.white,
              ),),

              SizedBox(height: 5.0),

              Text(_.likeBackData.gender, style: TextStyle(
                color: Colors.amberAccent[200],
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),),

              SizedBox(height: 30.0),


              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white,),

                  SizedBox(width: 10),

                  Text("${_.likeBackData.location.country}, ${_.likeBackData.location.area}", style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,

                  ),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      regController.matchUsers(ProfileData(uid: widget.uid));
                    },
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                  Padding(padding: EdgeInsets.only(right: 8.0)),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () async {
                      String roomId=widget.uid+"_"+FirebaseAuth.instance.currentUser.uid;
                      await FirebaseFirestore.instance.collection('ChatRoom').doc(roomId).get().then((document){
                        if (document.exists){
                          Get.to(ChatBoxNew(roomId));
                        }else{
                          roomId=FirebaseAuth.instance.currentUser.uid+"_"+widget.uid;
                          Get.to(ChatBoxNew(roomId));
                        }
                      });
                      regController.matchUsers(ProfileData(uid: widget.uid));
                    },
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite, color: Colors.green),
                  ),
                  Padding(padding: EdgeInsets.only(right: 8.0)),
                ],
              ),
            ],
          ):Container(
            child: CircularProgressIndicator(),
            padding: EdgeInsets.all(10),
          ),

        ),
      )
      ;});
  }
}