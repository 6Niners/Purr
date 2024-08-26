import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/NewChat/chat.dart';
import 'package:purr/NewChat/chat_list%20view.dart';
import 'package:purr/Profile/FetchProfilePage.dart';
import 'package:purr/Registration/ChangePassword.dart';
import 'package:purr/Registration/RegistrationController.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/icon.png",
    "assets/icon.png",
    "assets/Not_Found.png",
  ];
  CardController controller; //Use this to trigger swap.

  @override
  void initState() {
    RegistrationController controller = Get.find();
    controller.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabCont = TabController(vsync: this, length: 3);
    return SafeArea(
      child: new Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: TabBar(
          controller: tabCont,
          labelPadding: EdgeInsets.all(20),
          indicatorPadding: EdgeInsets.all(500),
          indicatorColor: Colors.red,
          tabs: [
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(icon: Icon(Icons.chat)),
            Tab(icon: Icon(Icons.account_box)),
          ],
        ),
        body: TabBarView(
          //physics: TabCont.index==0?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          controller: tabCont,
          children: [
            likeDislikeScreen(context, controller),
            ChatRoom(),
            Column(
              children: [
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  onPressed: () {
                    Get.to(ChangePasswordPage());
                  },
                  color: Colors.grey[800],
                  child: Text(
                    "Change Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  onPressed: () {
                    Get.to(FetchProfilePage());
                  },
                  color: Colors.grey[800],
                  child: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10)),
                  onPressed: () async {
                    RegistrationController controller = Get.find();
                    await controller.signOut();
                  },
                  color: Colors.grey[800],
                  child: Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column likeDislikeScreen(BuildContext context, CardController controller) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<RegistrationController>(builder: (_) {
          return buildStackCards(context, controller, _);
        }),
        buttonsRow(),
      ],
    );
  }

  startANewChat(int index, RegistrationController getXController) async {
    String chatRoomID = FirebaseAuth.instance.currentUser.uid +
        "_" +
        getXController.users[index].uid;
    await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomID)
        .get()
        .then((document) {
      if (document.exists) {
        Get.to(ChatBoxNew(chatRoomID));
      } else {
        chatRoomID = getXController.users[index].uid +
            "_" +
            FirebaseAuth.instance.currentUser.uid;
        Get.to(ChatBoxNew(chatRoomID));
      }
    });
  }

  Container buildStackCards(BuildContext context, CardController controller,
      RegistrationController getXController) {
    return Container(
      height: Get.height / 1.5,
      width: Get.width,
      child: TinderSwapCard(
        swipeUp: true,
        swipeDown: false,
        orientation: AmassOrientation.BOTTOM,
        totalNum: getXController.users.length,
        swipeEdge: 4.0,
        maxWidth: Get.width,
        maxHeight: Get.height,
        minWidth: Get.width * 0.8,
        minHeight: Get.height - 1,
        cardBuilder: (context, index) => Card(
          color: Colors.grey[800],
          child: Stack(
            children: [
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: getXController.users[index].avatarUrl,
                imageBuilder: (context, imageProvider) {
                  //print(GetxController.users[index].avatarUrl);
                  return Ink.image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(6.0),
                            margin: EdgeInsets.all(6),
                            child: IconButton(
                                icon: Icon(Icons.chat),
                                onPressed: () {
                                  startANewChat(index, getXController);
                                }))
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: Get.width,
                        height: Get.height / 5,
                        child: ListView.builder(
                            itemCount: getXController.users[0]
                                .toMapShowToUser()
                                .length,
                            itemBuilder: (BuildContext context, int indexList) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(1),
                                color: Colors.black38,
                                child: RichText(
                                    text: TextSpan(
                                        text: getXController.users[index]
                                                .toMapShowToUser()
                                                .keys
                                                .toList()[indexList] +
                                            ": ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: getXController.users[index]
                                              .toMapShowToUser()
                                              .values
                                              .toList()[indexList]),
                                    ])),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        cardController: controller = CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping
            //print("left");
          } else if (align.x > 0) {
            //Card is RIGHT swiping
            //print("right");
          }
          if (align.y < 0) {
            //Card is LEFT swiping
            //print("up");
          } else if (align.y > 0) {
            //Card is RIGHT swiping
            //print("down");
          }
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          //print(welcomeImages[index]);
          //print(orientation);
          Get.find<MainPageController>().checkSwipe(orientation, index);

          /// Get orientation & index of swiped card!
        },
      ),
    );
  }

  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.loop, color: Colors.yellow),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: null,
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.star, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
