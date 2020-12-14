import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';

import 'package:purr/UI_Widgets.dart';
class RegistrationController extends GetxController{


  @override
  Future<void> onInit() async {
    Firebase.initializeApp();
    super.onInit();
  }
Future<void> signIn(String email,String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(MainPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ShowToast('No user found for that email.',Background_color: Colors.red);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ShowToast('Wrong password provided for that user.',Background_color: Colors.red);
      }
    }

}


Future<void> signUp(String email,String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    Get.to(MainPage());
  } on FirebaseAuthException catch(e){
    print(e.code);
    if (e.code == 'weak-password'){
      print('The password provided is very weak');
      ShowToast('The password provided is very weak',Background_color: Colors.red);
    } else if (e.code == 'email-already-in-use'){
      print('This email is already in use, try to sign in instead');
      ShowToast('This email is already in use, try to sign in instead',Background_color: Colors.red);
    }else{
      ShowToast(e.message,Background_color: Colors.red);}

  } catch(e){
    print(e.toString());
  }
}

  Future<void> forgotpassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      ShowToast("Reset password link has sent your mail please use it to change the password.",Background_color: Colors.blue);
    } on FirebaseAuthException catch(e){
      print(e.code);
      if (e.code == 'user-not-found'){

        ShowToast('There is no user with that email',Background_color: Colors.red);
      }
      else{
      ShowToast(e.message,Background_color: Colors.red);}
  }
  }

}
