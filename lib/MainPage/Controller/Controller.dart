import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MainController extends GetxController {


  @override
  Future<void> onInit() async {
    super.onInit();
  }
  // Start of swiping functions
  void CheckSwipe(CardSwipeOrientation orientation) {
    //enum CardSwipeOrientation { LEFT, RIGHT, RECOVER, UP, DOWN }
    //                          {   0  ,  1  ,    2   , 3 ,   4  }
    if (orientation.index == 0) {
      SwipeLeft();
    }
    if (orientation.index == 1) {
      SwipeRight();
    }
    if (orientation.index == 3) {
      SwipeUp();
    }
  }

  //in each of those functions do the function in the database
  void SwipeLeft() {
    String Left = "Left";
    ShowToast(Left);
    print(Left);
  }

  void SwipeRight() {
    String RIGHT = "RIGHT";
    ShowToast(RIGHT);
    print(RIGHT);
  }

  void SwipeUp() {
    String UP = "UP";
    ShowToast(UP);
    print(UP);
  }

  //end of swiping functions
  Future<void> ShowToast(String text) async {
      Fluttertoast.showToast(
          msg: text,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[850],
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

}