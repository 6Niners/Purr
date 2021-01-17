
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purr/Registration/RegistrationController.dart';

///////////////////////////////////////////


class ChatBoxNew extends StatefulWidget {
  ChatBoxNew(this.Chatroom); //widget

  String Chatroom = "69";

  @override
  _ChatBoxNewState createState() => _ChatBoxNewState();
}

class _ChatBoxNewState extends State<ChatBoxNew> {

  String receivername = "pet name";
  String sendername = "Sender";

  ///////////////////////////////////////////

  ///////////////////////////////////////////
  Widget chatMessages() {
    var chat = FirebaseFirestore.instance.collection(
        'ChatRoom').doc(widget.Chatroom).collection('messages').orderBy("time", descending: false);
    // print('work work work work work');
    //buid a widget to view the messages
    return Container(
      height: 1000,
      child: StreamBuilder<QuerySnapshot>(
        stream: chat.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              bool sendByMe = false;
              if (document.data()['sendBy'] == sendername) {
                sendByMe = true;
              } else {
                sendByMe = false;
              }
              return Container(
                padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: sendByMe ? 0 : 24,
                    right: sendByMe ? 24 : 0),
                alignment: sendByMe ? Alignment.centerRight : Alignment
                    .centerLeft,
                child: Container(
                  margin: sendByMe
                      ? EdgeInsets.only(left: 30)
                      : EdgeInsets.only(right: 30),
                  padding: EdgeInsets.only(
                      top: 17, bottom: 17, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: sendByMe ? BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomLeft: Radius.circular(23)
                      ) :
                      BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
                      color: sendByMe ?
                      Get.theme.focusColor:Get.theme.cardColor
                  ),
                  child: Text(document.data()['message'],
                      textAlign: TextAlign.start,
                      style: Get.theme.textTheme.bodyText2),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  //////////////////////////////////////////
  //            Chat Functions            //
  //////////////////////////////////////////
  BackgroundForChat() async {
    RegistrationController REGCONT = Get.find();
    await REGCONT.getUserProfileData();


    if ( REGCONT.UserInfo.petType =='cat') {

      return "assets/wallpaper-cat.jpg";
    }

    else if (REGCONT.UserInfo.petType == 'dog') {
      return "assets/dog.jpg";  }

    else if (REGCONT.UserInfo.petType == 'hamster') {
      return "assets/hamster.jpg";  }

    else if (REGCONT.UserInfo.petType == 'rabbit') {
      return "assets/rabbit.jpg";  }

    else if (REGCONT.UserInfo.petType == 'bird'){
      return "assets/wallpaper-bird.jpg";  }

    else{
      return "assets/other.jpg";
    }
  }
///////////////////////////////////////////
  Future<void> takePicture() async {
    // print('function works');
    ImagePicker _picker = ImagePicker();
    _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600.0,
      maxHeight: 700.0,
      imageQuality: 25,
      preferredCameraDevice: CameraDevice.front,
    );
  }

  ///////////////////////////////////////////

  Future<void> pickpicture() async {
    // print('function works');
    final picker = ImagePicker();
    picker.getImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 700,
        imageQuality: 50
    );
  }

  ///////////////////////////////////////////


/*  void _sendImage({String messageText, String imageUrl}) {
    chatReference.add({
      'text': messageText,
      'sender_id': Widget.prefs.getString('uid'),
      'sender_name': Widget.prefs.getString('name'),
      'profile_photo': Widget.prefs.getString('profile_photo'),
      'image_url': imageUrl,
      'time': FieldValue.serverTimestamp(),
    });
  } */

  ///////////////////////////////////////////

   addMessage(String Message) {
    // print('function works'+ Message);

    //function to writ the message
    if (Message.isNotEmpty) { // if there is something in the writing bare
      Map<String, dynamic> chatroomMap = {

        //save the data in the database using mapping
        "sendBy": sendername,
        "message": Message,
        "time": DateTime.now(),
        'sender_id': widget.Chatroom,
      };
      addmessage(widget.Chatroom, chatroomMap);
    }
    else {
      return ("please write a message");
    }
  }

  //////////////////////////////////////////

  addmessage(String chatroomID, chatroomMap) {
    //function to create a chat room in the data base
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomID).collection("messages") //the document is an id store place
    // the set data is a place to store the data
        .add(chatroomMap)
        .catchError((e) {
      print(e.toString());
    }); //if there is any error
  }

  createChatRoom() async {
    if(receivername=="pet name"){
    //function to create a chat room in the data base
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    await user.doc(widget.Chatroom.toString().replaceAll("_", "").replaceAll(FirebaseAuth.instance.currentUser.uid, "")).get().then((document){
      if (document.exists){
        //print(receivername);
        receivername= document.data()['Pet Name'];
        print(receivername);
        setState(() {
        });
      }
    });
    RegistrationController CONT = Get.find();
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(this.widget.Chatroom).set({
      "users Names":receivername+"_"+CONT.UserInfo.petName,
      "users list":[widget.Chatroom.toString().replaceAll("_", "").replaceAll(FirebaseAuth.instance.currentUser.uid, ""),FirebaseAuth.instance.currentUser.uid],
      "users":widget.Chatroom})
        .catchError((e) {
      print(e.toString());
    });
    sendername=CONT.UserInfo.petName;
    }
  }

//////////////////////////////////////////

  buildMessageComposer() {
    TextEditingController Message = TextEditingController();
    return Container(
      padding: EdgeInsets.all(10),
      height: 60.0,
      color: Get.theme.cursorColor,
      //color: Color(0xFFB2EBF2),
      //color: Color(0xFFFFCDD2),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            iconSize: 25.0,
            color: Get.theme.textTheme.bodyText2.color,
            //color: Colors.redAccent,
            onPressed: () => {takePicture()},
          ),
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: Get.theme.textTheme.bodyText2.color,
              //color: Colors.redAccent,
              onPressed: () async {
                /*  var image = await ImagePicker.pickImage(
                    source: ImageSource.gallery);
                int timestamp = new DateTime.now().millisecondsSinceEpoch;
                FirebaseStorage storage = FirebaseStorage.instance;
                Reference ref = storage.ref().child(
                    "image" + DateTime.now().toString());
                UploadTask uploadTask = ref.putFile(image);
                String fileUrl;
                uploadTask.then((res) async {
                  fileUrl = await res.ref.getDownloadURL();
                });  */
                //    _sendImage(messageText: null, imageUrl: fileUrl);
              }),

          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: Message,
              style: Get.theme.textTheme.bodyText2,
              decoration: InputDecoration.collapsed(
                hintText: 'meow your message',
                hintStyle: Get.theme.textTheme.bodyText2
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Get.theme.textTheme.bodyText2.color,
            //color: Colors.redAccent,
            onPressed: () { addMessage(Message.text);
              Message.text="";
            }, //onPressed
          ),

        ],
      ),
    );
  }
  /////////////////////////////////////////
  //             Chat UI                 //
  /////////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    createChatRoom();
    //createChatRoom(FirebaseAuth.instance.currentUser.uid+"_"+"Another user1");
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/rabbit.jpg"),//BackgroundForChat()),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1), //appBar color
          title: Text(receivername,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(child: chatMessages()),
              buildMessageComposer(),
            ],
          ),
        ),
      ),
    );
  }
}//class ChatBox1