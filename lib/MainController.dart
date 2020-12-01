
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'file:///F:/AndroidStudioProjects/Purr/lib/MainPage/MainPageController.dart';
import 'package:purr/Registration/RegistrationController.dart';

class MainController extends GetxController {


  @override
  Future<void> onInit() async {
    Get.put(MainPageController());
    Get.put(RegistrationController());
    super.onInit();
  }
}