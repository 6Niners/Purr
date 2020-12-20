//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  import 'dart:io';
  import 'package:chatapp/widget/widget.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget chatMessages(){                                                   //buid a widget to view the messages
    return StreamBuilder(                                                 //return and stream the chat section from the data base with last update
      stream: chats,
        builder: (context, snapshot){                                      //use the builder to view all the data in case found
          if(snapshot.hasData){
            if(snapshot.hasError){                                        // check if there is an error
            return ("Something Went Wrong");
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length,                    //the length of documents that we have created in our database and to retrieve data stored in Cloud Firestore
                itemBuilder: (context, index){                            // the function is to get only last item in the chat with any data type
                  return LastMessageTile(                                  // the return the last message as in tile funnction
                  message: snapshot.data.documents[index].data["message"],
                  );
                }
            );
          }
          else{
            return Text("write somthing to" +widget.prefs.getString('name')); // if it is the first time to talke     //lw fe w2t h3'yrha le sora
          }
        },
    );
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  addMessage() {
    //function to writ the message
    if (messageController.text.isNotEmpty) {                          // if there is somthing in the writing bare
      Map<String, dynamic> chatroomMap = {                            //save the data in the database using mapping
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        "time": DateTime.now()
        'sender_id': widget.prefs.getString('uid'),
      };
    }
    else {
      return ("please write a message");
    }
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
creatChatRoom(string chatroomID,chatroomMap) {
  //function to creat a chat room in the data base
  Firestore.instance.collection("ChatRoom")
      .document(chatroomID) //the document is an id store place
      .setData(chatroomMap) // the setdata is a place to store the data
      .catchError((e) {
    print(e.toString());
  }); //if there is any error
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// this class to make the massage as in a blook that needs a UI to view the message in it
  class LastMessageTile extends StatelessWidget {
    final String message;
    MessageTile({@required this.message });
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////