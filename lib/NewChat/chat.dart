
import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:path/path.dart';

///////////////////////////////////////////


class ChatBoxNew extends StatefulWidget {

  String chatRoom = "";
  ChatBoxNew(this.chatRoom); //widget

  @override
  _ChatBoxNewState createState() => _ChatBoxNewState();
}

class _ChatBoxNewState extends State<ChatBoxNew> {
  RegistrationController controller = Get.find();
  String receiverName = "pet name";
  String senderName = "Sender";


  ///////////////////////////////////////////

  ///////////////////////////////////////////
  Widget chatMessages() {
    var chat = FirebaseFirestore.instance.collection('ChatRoom').doc(widget.chatRoom).collection('messages').orderBy("time", descending: false);
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
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              bool sendByMe = false;
              if (document.data()['sendBy'] == senderName) {
                sendByMe = true;
              } else {
                sendByMe = false;
              }
              bool image = false;
              if (document.data()['type'] == "Image") {
                image = true;
              } else {
                image = false;
              }
              if(image) {
                return Stack(
                  children: [
                    Container(
                      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
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
                        ),
                        child: CachedNetworkImage(
                          height: Get.height / 4,
                          width: Get.width/2,
                          imageUrl: document.data()['message'],
                          imageBuilder: (context, imageProvider) {
                            return Ink.image(
                              image: imageProvider,
                            );
                          },
                          progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),),
                    ),

                  ],
                );
              }else{
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
                      color: sendByMe ? Get.theme.focusColor:Get.theme.cardColor
                  ),
                  child: Text(document.data()['message'],
                      textAlign: TextAlign.start,
                      style: Get.theme.textTheme.bodyText2),
                ),
              );
              }}).toList(),
          );

        },
      ),
    );
  }

  //////////////////////////////////////////
  //            Chat Functions            //
  //////////////////////////////////////////

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

  createImageMessage() async {
    // print('function works'+ Message);
      String _imageURL;
      var image=await ImagePicker().getImage(source: ImageSource.gallery);
      String fileName = basename(image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then(
              (value) { print("Done: $value"); _imageURL=value;
              // if there is something in the writing bare
              Map<String, dynamic> chatRoomMap = {
                //save the data in the database using mapping
                "sendBy": senderName,
                "message": _imageURL,
                "type": "Image",
                "time": DateTime.now(),
                'sender_id': widget.chatRoom,
              };
              addmessage(widget.chatRoom, chatRoomMap);
          }
      );




  }

  ///////////////////////////////////////////

   createMessageMap(String message) {
    // print('function works'+ Message);
      //function to writ the message
    if (message.isNotEmpty) { // if there is something in the writing bare
      Map<String, dynamic> chatRoomMap = {
        //save the data in the database using mapping
        "sendBy": senderName,
        "message": message,
        "type":"text",
        "time": DateTime.now(),
        'sender_id': widget.chatRoom,
      };
      addmessage(widget.chatRoom, chatRoomMap);
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

    //function to create a chat room in the data base
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    await user.doc(widget.chatRoom.toString().replaceAll("_", "").replaceAll(FirebaseAuth.instance.currentUser.uid, "")).get().then((document){
      if (document.exists){
        //print(receivername);
        receiverName= document.data()['Pet Name'];
        print(receiverName);
        setState(() {
        });
      }
    });

    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(this.widget.chatRoom).set({
      "users Names":receiverName+"_"+controller.userInfo.petName,
      "users list":[widget.chatRoom.toString().replaceAll("_", "").replaceAll(FirebaseAuth.instance.currentUser.uid, ""),FirebaseAuth.instance.currentUser.uid],
      "users":widget.chatRoom})
        .catchError((e) {
      print(e.toString());
    });
    senderName=controller.userInfo.petName;
  }

//////////////////////////////////////////

  buildMessageComposer() {
    TextEditingController messageController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(10),
      height: 60.0,
      color: Get.theme.cursorColor,
      //color: Color(0xFFB2EBF2),
      //color: Color(0xFFFFCDD2),
      child: Row(
        children: <Widget>[
         /* IconButton(
            icon: Icon(Icons.camera),
            iconSize: 25.0,
            color: Get.theme.textTheme.bodyText2.color,
            //color: Colors.redAccent,
            onPressed: () => {takePicture()},
          ),*/
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25.0,
              color: Get.theme.textTheme.bodyText2.color,
              //color: Colors.redAccent,
              onPressed: () async {
                createImageMessage();
              }),

          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: messageController,
              textInputAction: TextInputAction.done,
              onEditingComplete: (){createMessageMap(messageController.text);
              messageController.text="";},
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
            onPressed: () { createMessageMap(messageController.text);
              messageController.text="";
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
  void initState() {
    createChatRoom();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    //createChatRoom(FirebaseAuth.instance.currentUser.uid+"_"+"Another user1");
    return
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                image: AssetImage(controller.background),//BackgroundForChat()),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xFF0D47A1), //appBar color
            title: Text(receiverName,
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