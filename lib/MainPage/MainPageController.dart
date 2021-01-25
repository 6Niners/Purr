import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:purr/UI_Widgets.dart';

class MainPageController extends GetxController {


  @override
  Future<void> onInit() async {
    super.onInit();
  }



  // Start of swiping functions
  void checkSwipe(CardSwipeOrientation orientation) {
    //enum CardSwipeOrientation { LEFT, RIGHT, RECOVER, UP, DOWN }
    //                          {   0  ,  1  ,    2   , 3 ,   4  }
    RegistrationController regController =Get.find();
    if (orientation.index == 0) {
      swipeLeft();
      regController.addUserSwipeLeft(regController.users[0]);
    }
    if (orientation.index == 1) {
      swipeRight();
      regController.addUserSwipeRight(regController.users[0]);
    }
    if (orientation.index == 3) {
      swipeUp();
    }
    //removes user from list when the user is swiped
    regController.users.removeAt(0);
  }

  //in each of those functions do the function in the database
  void swipeLeft() {
    String left = "left";
    ShowToast(left);
    print(left);
  }

  void swipeRight() {
    String right = "right";
    ShowToast(right);
    print(right);
  }

  void swipeUp() {
    String up = "up";
    ShowToast(up);
    print(up);
  }

  //end of swiping functions


}