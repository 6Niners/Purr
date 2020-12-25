
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ChatBox1 extends StatelessWidget {
  ///////////////////////////////////////////
  String receivername = "";
  String sendername = "";
  String senderid = "";
  Stream chats;

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
    print('function works');
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
      creatChatRoom('1', chatroomMap);
    }
    else {
      return ("please write a message");
    }
  }

  //////////////////////////////////////////
  creatChatRoom(String chatroomID, chatroomMap) {
    //function to create a chat room in the data base
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomID) //the document is an id store place
        .set(chatroomMap) // the setdata is a place to store the data
        .catchError((e) {
      print(e.toString());
    }); //if there is any error
  }

  /////////////////////////////////////////


  buildMessageComposer() {
    TextEditingController Message = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white60,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent, //appBar color
        title: Text(
          'petName or userName',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: buildMessageComposer(),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } //widget
}//class ChatBox1