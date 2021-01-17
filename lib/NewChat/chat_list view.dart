import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:purr/NewChat/chat.dart';
/*
class FlutterIcons {
FlutterIcons._();

static const _kFontFam = 'FlutterIcons';

static const IconData home = IconData(0xe800, fontFamily: _kFontFam);
static const IconData chat = IconData(0xe83f, fontFamily: _kFontFam);
static const IconData search = IconData(0xe86f, fontFamily: _kFontFam);
static const IconData menu = IconData(0xe871, fontFamily: _kFontFam);
static const IconData back = IconData(0xe879, fontFamily: _kFontFam);
static const IconData filter = IconData(0xf1de, fontFamily: _kFontFam);
}



class AppColors {
  static Color mainColor = Color(0XFF252331);
  static Color darkColor = Color(0XFF1e1c26);
  static Color blueColor = Color(0XFF2c75fd);
}
/*
class ChatModel {
  final bool isTyping;
  final String lastMessage;
  final String lastMessageTime;
  final String sendername;

  ChatModel(
      {this.isTyping, this.lastMessage, this.lastMessageTime,this.sendername});

  static List<ChatModel> list = [
  ChatModel (
  isTyping: true,
  lastMessage: "hello!",
  lastMessageTime: "2d",
  sendername: "AHMED",
  ),
  ];
}

*/
class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
   final bool isTyping;
   final String lastMessage;
   final String lastMessageTime;
   final String sendername;
   final items = List<String>.generate(10000, (i) => "Item $i");


   _ChatPageState(
      {this.isTyping, this.lastMessage, this.lastMessageTime,this.sendername});

  @override
  Widget build(BuildContext context) {
    var chat = FirebaseFirestore.instance.collection('ChatRoom').orderBy("time", descending: false);

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Chat",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: AppColors.darkColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FlutterIcons.search,
                  color: Colors.white54,
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          Expanded(
                child: Container(
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
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatBox(),
                              ),
                            );
                          },









                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              image: DecorationImage(
                                image: ExactAssetImage("assets/default.jpg"),
                              ),
                            ),
                          ),
                          title: Text(
                            document.data()["sender name"],
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: document.data()["isTyping"]
                              ? Row(
                            children: <Widget>[
                              /*
                      SpinKitThreeBounce(
                        color: AppColors.blueColor,
                        size: 20.0,
                      ),*/
                            ],
                          )
                              : Row(
                            children: <Widget>[
                              Text(
                                document.data()[lastMessage],
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(width: 25),
                              Text(
                                document.data()[lastMessageTime] +
                                    " days ago",
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList());
                }),
                )
                )

        ],

      ),
    );
  }
}

*/
//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
class CustomTheme {
  static Color colorAccent = Color(0xff007EF4);
  static Color textColor = Color(0xff071930);
}


/////////////////////////////////////////////////////////
class Constants{

  static String myName = "";
}
///////////////////////////////////////////////////////////////////////////////



class ChatRoom extends StatefulWidget {
  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoom> {
  //this one is for the general use
  var chatRooms = FirebaseFirestore.instance.collection("ChatRoom").where("users list", arrayContains: FirebaseAuth.instance.currentUser.uid).snapshots();
//testing one
  //var chatRooms = FirebaseFirestore.instance.collection("ChatRoom").where("users list", arrayContains: "Q3GtQdi0mKOtui9GzrNPUP5DgE63").snapshots();
  var collection;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong',style: TextStyle(color: Colors.red,fontSize: 25),);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading",style: TextStyle(color: Colors.green,fontSize: 25),);
        }
        /*
        if(snapshot.data.docs.length==0){
          return ChatRoomsTile(userName: "New Chat", chatroomID: FirebaseAuth.instance.currentUser.uid+"_"+"Meow", );
        }*/
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatRoomsTile(
              userName: snapshot.data.docs[index].data()['users']
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll(FirebaseAuth.instance.currentUser.uid, "")??"name",
              chatroomID: snapshot.data.docs[index].data()['users']??"name",
            );}
        );

      },
    );
  }

  @override
  void initState() {
  //  getUserInfogetChats();
    super.initState();
  }
/*
  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: Container(
        child: chatRoomsList(),
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
  final String chatroomID;

  ChatRoomsTile({this.userName,@required this.chatroomID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatBoxNew(
                chatroomID
              //chatroomID: chatroomID,
            )
        ));
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