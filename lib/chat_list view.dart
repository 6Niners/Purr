/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purr/Chat/Chat_screen_UI.dart';

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
  sendername: "mmmmmmmmm",
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FlutterIcons.filter,
              color: AppColors.blueColor,
            ),
            onPressed: null,
          )
        ],
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
              child: ListView.builder(
               itemCount: items.length,
                itemBuilder: (context, index){
                var chat = FirebaseFirestore.instance.collection('ChatRoom').orderBy("time", descending: false);
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
                children: snapshot.data.docs.map((DocumentSnapshot document)
                return Container(child: document.data()['sendBy'] ,Text(document.data()['message'],);
                  data ['message'].lastMessage
                )
              )
              );
          }
          )

      );
   }
 )






               itemCount: list.length,
               itemBuilder: (context, index) {
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
                    list[index].sendername,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: list[index].isTyping
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
                        list[index].lastMessage,
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                       list[index].lastMessageTime + " days ago",
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white24,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.chat),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.menu),
            title: Text(""),
          ),
        ],
      ),
    );
  }
}

*/