import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/Registration/RegistrationController.dart';

class MainController extends GetxController {


  @override
  Future<void> onInit() async {
    Get.put(MainPageController());
    Get.put(RegistrationController());
    super.onInit();
  }
}