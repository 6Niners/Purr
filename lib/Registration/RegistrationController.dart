import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
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


Future<void> signUp(GlobalKey<FormState> _formKey,String email,String password) async {
  final formState = _formKey.currentState;

  try {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    Get.to(MainPage());
  } on FirebaseAuthException catch(e){
    if (e.code == 'weak-password'){
      print('The password provided is very weak');
    } else if (e.code == 'email-already-in-use'){
      print('This email is already in use, try to sign in instead');
    }
  } catch(e){
    print(e.toString());
  }
}



}
