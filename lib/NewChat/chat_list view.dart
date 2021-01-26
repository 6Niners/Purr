import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/NewChat/chat.dart';
import 'package:purr/Profile/Avatar.dart';
import 'package:purr/Registration/RegistrationController.dart';

class CustomTheme {
  static Color colorAccent = Color(0xff007EF4);
  static Color textColor = Color(0xff071930);
}

class ChatRoom extends StatefulWidget {
  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom> {
  RegistrationController controller = Get.find();
  Stream<QuerySnapshot> chatRooms = FirebaseFirestore.instance.collection("ChatRoom").where("users list", arrayContains: FirebaseAuth.instance.currentUser.uid).snapshots();
  Stream<DocumentSnapshot> matchesStream = FirebaseFirestore.instance.collection("UserData").doc(FirebaseAuth.instance.currentUser.uid).snapshots();
  var collection;
  Widget matches() {
    //check if the person in swiped for is the in swiped right
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Likes You",style: Get.theme.textTheme.headline6,),
            ],
          ),
        ),
        StreamBuilder(
          stream: matchesStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong',style: TextStyle(color: Colors.red,fontSize: 25),);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading",style: TextStyle(color: Colors.green,fontSize: 25),));
            }
            try{
              // ignore: unnecessary_statements
              if(snapshot.data['Swiped Right For'].length==0){
                return Center(
                  child: Container(
                    child: Text("None likes you yet",style: TextStyle(color: Colors.red,fontSize: 20),), ),
                );
              }
            }catch(_){
              return Center(
                child: Container(
                  child: Text("None likes you yet",style: TextStyle(color: Colors.red,fontSize: 20),), ),
              );
            }

            return Container(
              height: 100,
              child: ListView.builder(
                  itemCount: snapshot.data['Swiped Right For'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    //print(snapshot.data['Swiped Right For'].toString().substring(snapshot.data['Swiped Right For'].toString().indexOf("_")+1));
                    var selectedItem=(snapshot.data['Swiped Right For'] as List)?.map((item) => item as String)?.toList()[index];
                    return MatchesTile(
                      avatarUrl:selectedItem.substring(selectedItem.indexOf("_")+1),
                      otherUserUID: selectedItem.split("_")[0],
                    );
                  }
              ),
            );

          },
        ),
      ],
    );
  }

  Widget chatRoomsList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Chats",style: Get.theme.textTheme.headline6,),
            ],
          ),
        ),
        StreamBuilder(
          stream: chatRooms,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong',style: TextStyle(color: Colors.red,fontSize: 25),);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading",style: TextStyle(color: Colors.green,fontSize: 25),));
            }
            if(snapshot.data.docs.length==0){
              return Center(
                child: Container(
                  child: Text("There no chats",style: TextStyle(color: Colors.red,fontSize: 20),), ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data.docs[index].data()['users']);
                var userNames=snapshot.data.docs[index].data()['users Names'].toString().split("_");
                userNames.remove(controller.userInfo.petName);
                String username=userNames[0];
                return ChatRoomsTile(
                  userName: username,
                  chatRoomID: snapshot.data.docs[index].data()['users'],
                );}
            );

          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: Column(
        children: [
          matches(),
          chatRoomsList(),
        ],
      ),

    /*
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },

      ),*/
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomID;
  ChatRoomsTile({this.userName,this.chatRoomID});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ChatBoxNew(chatRoomID));
      },
      child: Container(
        color: Get.theme.canvasColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Get.theme.highlightColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(userName.substring(0, 1),
                    textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
              style: Get.theme.textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
Future<void> likeBack() async {
  RegistrationController controller = Get.find();
  controller.likeBack=false;
  await Get.dialog(
    AlertDialog(
      backgroundColor: Colors.grey[700],
      title: new Text(
        'Like Back',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Get.back();
            //registraioon controller remove from list
          },
          child: new Text(
            'Delete from list',
          ),
        ),
        new FlatButton(
          onPressed: () {
            Get.back();
            controller.likeBack=false;
          },
          child: new Text(
            'No',
          ),
        ),
        new FlatButton(
          onPressed: () {
            Get.back();
            controller.likeBack=true;
          },
          child: new Text(
            'Yes',
          ),
        ),
      ],
    ),
  );
}
class MatchesTile extends StatelessWidget {
  final String avatarUrl;
  String otherUserUID;
  MatchesTile({this.avatarUrl,this.otherUserUID});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
            await likeBack();
            RegistrationController controller = Get.find();
            if(controller.likeBack){
            String roomId=otherUserUID+"_"+FirebaseAuth.instance.currentUser.uid;
            await FirebaseFirestore.instance.collection('ChatRoom').doc(roomId).get().then((document){
            if (document.exists){
              Get.to(ChatBoxNew(roomId));
            }else{
              roomId=FirebaseAuth.instance.currentUser.uid+"_"+otherUserUID;
              Get.to(ChatBoxNew(roomId));
            }
            });
            controller.matchUsers(ProfileData(uid: otherUserUID));
            }
      },
      child: Center(
        child:Avatar(
          avatarUrl: avatarUrl,
        ),
      ),
    );
  }
}