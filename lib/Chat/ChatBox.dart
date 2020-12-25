import 'dart:async';
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  import 'dart:io';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ChatConroller extends GetxController {
  String receivername = "";
  String sendername = "";
  String senderid = "";
  Stream chats;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget chatMessages() {
    //build a widget to view the messages
    return StreamBuilder( //return and stream the chat section from the data base with last update
      stream: chats,
      builder: (context,
          snapshot) { //use the builder to view all the data in case found
        if (snapshot.hasData) {
          if (snapshot.hasError) { // check if there is an error
            return Text("Something Went Wrong");
          }
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              //the length of documents that we have created in our database and to retrieve data stored in Cloud Firestore
              itemBuilder: (context,
                  index) { // the function is to get only last item in the chat with any data type
                return Container( // the return the last message as in tile function
                  child: Text(snapshot.data.documents[index].data["message"]),
                );
              }
          );
        }
        else {
          return Text('Meow your message'); // if it is the first time to talker
        }
      },
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  addMessage(String Message) {
    //function to writ the message
    if (Message.isNotEmpty) { // if there is something in the writing bare
      Map<String, dynamic> chatroomMap = {
        //save the data in the database using mapping
        "sendBy": sendername,
        "message": Message,
        "time": DateTime.now(),
        'sender_id': senderid,
      };
    }
    else {
      return ("please write a message");
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  creatChatRoom(String chatroomID, chatroomMap) {
    //function to creat a chat room in the data base
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomID) //the document is an id store place
        .set(chatroomMap) // the setdata is a place to store the data
        .catchError((e) {
      print(e.toString());
    }); //if there is any error
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////