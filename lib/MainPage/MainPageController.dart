import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:purr/UI_Widgets.dart';

class MainPageController extends GetxController {


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


}