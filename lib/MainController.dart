import 'package:get/get.dart';
import 'package:purr/MainPage/MainPageController.dart';
import 'package:purr/Registration/RegistrationController.dart';
import 'package:purr/Services/Database.dart';


class MainController extends GetxController {


  @override
  Future<void> onInit() async {
    Get.put(MainPageController());
    Get.put(RegistrationController());
    Get.put(DatabaseService());
    super.onInit();
  }
}