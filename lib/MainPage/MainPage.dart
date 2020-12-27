import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/Registration/ChangePassword.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/icon.png",
    "assets/icon.png",
    "assets/Not_Found.png",
  ];
  CardController controller; //Use this to trigger swap.
  @override
  Widget build(BuildContext context) {
    TabController TabCont=TabController(vsync:this,length: 3);

    return SafeArea(
      child: new Scaffold(

        backgroundColor: Colors.grey[900],
        appBar: TabBar(
          controller: TabCont,
          labelPadding: EdgeInsets.all(20),
          indicatorPadding: EdgeInsets.all(500),
          indicatorColor: Colors.red,
      tabs: [
      Tab(icon: Icon(Icons.favorite),),
      Tab(icon: Icon(Icons.chat)),
      Tab(icon: Icon(Icons.account_box)),
      ],
      ),


        body: TabBarView(
          //physics: TabCont.index==0?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          controller: TabCont,
          children: [
            Like_Dislike_Screen(context, controller),
            Icon(Icons.directions_car),
          FlatButton(

      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
    onPressed: (){Get.to(ChangePasswordPage()); },
    color:Colors.grey[800],
    child: Text("Change Password",style: TextStyle(color: Colors.white),),)
          ],

        ),
      ),
    );
  }

  Column Like_Dislike_Screen(BuildContext context, CardController controller) {
    return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              BuildStackCards(context, controller),
              buttonsRow(),
            ],
          );
  }

  Container BuildStackCards(BuildContext context, CardController controller) {
    return Container(
          height: MediaQuery.of(context).size.width * 0.9,

          child: new TinderSwapCard(
            swipeUp: true,
            swipeDown: false,
            orientation: AmassOrientation.BOTTOM,
            totalNum: welcomeImages.length,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Card(
              color: Colors.grey[800],
              child: Image.asset('${welcomeImages[index]}'),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback:
                (DragUpdateDetails details, Alignment align) {
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
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {

              //print(welcomeImages[index]);
              //print(orientation);
              Get.find<MainPageController>().CheckSwipe(orientation);
              /// Get orientation & index of swiped card!
            },
          ),
        );
  }
  Widget buttonsRow() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 48.0),
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