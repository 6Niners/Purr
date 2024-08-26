import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:firebase_core/firebase_core.dart';

class MainController extends GetxController {
  @override
  Future<void> onInit() async {
    await Firebase.initializeApp();
    await Get.put(MainPageController());
    await Get.put(RegistrationController());
    await super.onInit();
  }
}
