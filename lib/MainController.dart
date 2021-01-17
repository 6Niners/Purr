import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:firebase_core/firebase_core.dart';

class MainController extends GetxController {


  @override
  Future<void> onInit() async {
    await Firebase.initializeApp();
    Get.put(MainPageController());
    Get.put(RegistrationController());
    super.onInit();
  }
}