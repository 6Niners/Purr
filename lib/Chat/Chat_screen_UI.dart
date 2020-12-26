
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


///////////////////////////////////////////


class ChatBox extends StatelessWidget {

  String receivername = " pet name";
  String sendername = "Sender";
  String senderid = "6969";

  ///////////////////////////////////////////

  ///////////////////////////////////////////
  Widget chatMessages() {
    var chat = FirebaseFirestore.instance.collection(
        'ChatRoom').doc(senderid).collection('messages').orderBy("time",descending: false);
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
              bool sendByMe=false;
              if(document.data()['sendBy']==sendername){
                sendByMe=true;
              }else{
                sendByMe=false;
              }
              return Container(
                padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: sendByMe ? 0 : 24,
                    right: sendByMe ? 24 : 0),
                alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
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
                      gradient: LinearGradient(

                        colors: sendByMe ? [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ]
                            : [
                          const Color(0xFFFF1744),
                          const Color(0xFFD50000)
                        ],
                      )
                  ),
                  child: Text(document.data()['message'],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
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
          buildMessageComposer(),
        ],
      ),
    );
  } //widget
  buildMessageComposer() {
    TextEditingController Message = TextEditingController();
    return Container(
      padding: EdgeInsets.all(10),
      height: 60.0,
      color: Colors.pink[50],
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