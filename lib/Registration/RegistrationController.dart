import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
class RegistrationController extends GetxController{


  @override
  Future<void> onInit() async {
    Firebase.initializeApp();
    super.onInit();
  }
Future<void> signIn(GlobalKey<FormState> _formKey,String email,String password) async {
  final formState = _formKey.currentState;

  if (formState.validate()) {
    formState.save();
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(MainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}


}