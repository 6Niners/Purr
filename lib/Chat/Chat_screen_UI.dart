
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


///////////////////////////////////////////


class ChatBox1 extends StatelessWidget {

  String receivername = " pet name";
  String sendername = "Sender";
  String senderid = "6969";

  ///////////////////////////////////////////

  ///////////////////////////////////////////
  Widget chatMessages() {
    Stream chats = FirebaseFirestore.instance.collection('ChatRoom')
        .snapshots();
    CollectionReference users = FirebaseFirestore.instance.collection(
        'ChatRoom').doc(senderid).collection('messages');
    // print('work work work work work');
    //buid a widget to view the messages
    return Container(
      height: 1000,
      child: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['message']),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  ///////////////////////////////////////////


    //////////////////////////////////////////
   //            Chat Functions            //
  //////////////////////////////////////////
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
  addMessage(String Message) {
    // print('function works'+ Message);

    //function to writ the message
    if (Message.isNotEmpty) { // if there is something in the writing bare
      Map<String, dynamic> chatroomMap = {

        //save the data in the database using mapping
        "sendBy": sendername,
        "message": Message,
        "time": DateTime.now(),
        'sender_id': senderid,
      };
      creatChatRoom( senderid, chatroomMap);
    }
    else {
      return ("please write a message");
    }
  }

  //////////////////////////////////////////
  creatChatRoom(String chatroomID, chatroomMap) {
    //function to create a chat room in the data base
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomID).collection("messages") //the document is an id store place
         // the set data is a place to store the data
    .add(chatroomMap)
        .catchError((e) {
      print(e.toString());
    }); //if there is any error
  }

    /////////////////////////////////////////
   //             Chat UI                 //
  /////////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent, //appBar color
        title: Text( receivername,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: chatMessages()),
          Flexible(fit: FlexFit.tight, child: SizedBox()),
          buildMessageComposer(),
        ],
      ),
    );
  } //widget
  buildMessageComposer() {
    TextEditingController Message = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 40.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () => {takePicture()},
          ),
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () => {pickpicture()},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: Message,
              decoration: InputDecoration.collapsed(
                hintText: 'meow your message',
              ),

            ),

          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () => { addMessage(Message.text)},
          ),
        ],
      ),
    );
  } //buildMessageComposer

}//class ChatBox1