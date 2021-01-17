import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Registration/SetupProfile.dart';
import 'package:purr/Registration/VerifyMail.dart';
import 'package:purr/Services/Database.dart';
import 'package:purr/UI_Widgets.dart';

import 'package:purr/Registration/CommonClasses-functions.dart';


class RegistrationController extends GetxController {
  User firebaseUser;


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = FirebaseAuth.instance.currentUser;
      if(firebaseUser.emailVerified){
        Get.offAll(MainPage());
      }else{
        Get.offAll(VerifyEmailPage());
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ShowToast(
            'No user found for that email.', Background_color: Colors.red);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ShowToast('Wrong password provided for that user.',
            Background_color: Colors.red);
      }
    }
  }


  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).updateUserData('null', 'null', 'null');
      Get.offAll(VerifyEmailPage());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is very weak');
        ShowToast(
            'The password provided is very weak', Background_color: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        print('This email is already in use, try to sign in instead');
        ShowToast('This email is already in use, try to sign in instead',
            Background_color: Colors.red);
      } else {
        ShowToast(e.message, Background_color: Colors.red);
      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> forgotpassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
      ShowToast(
          "Reset password link has sent your mail please use it to change the password.",
          Background_color: Colors.blue);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        ShowToast(
            'There is no user with that email', Background_color: Colors.red);
      }
      else {
        ShowToast(e.message, Background_color: Colors.red);
      }
    }
  }

  //if the user is logged in
  Future<bool> validatePassword(String password) async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> SendEmailVerification() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    firebaseUser.sendEmailVerification();
    ShowToast(
        "verification email has been sent", Background_color: Colors.blue);
  }

  Future<void> updatePassword(String password) async {
    firebaseUser = FirebaseAuth.instance.currentUser;

    firebaseUser.updatePassword(password);
    print("changed to " + password);
    ShowToast("Your password got changed", Background_color: Colors.blue);
  }

  void ismailverified() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    firebaseUser.reload();
    if (firebaseUser.emailVerified) {
      Get.offAll(SetupProfilePage());
    }
  }



//ui widgets to avoid repeating the same functions
  Container buildTextFormField(TextEditingController Controller,String labeltext,Function(String) Validator) {
    return Container(
        padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(5),
    child: TextFormField(
        validator:Validator,
        controller: Controller,
        style: Get.theme.textTheme.bodyText1,
        autovalidateMode: AutovalidateMode.disabled,
        decoration: InputDecoration(
            labelText: labeltext,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,),),
        )
    )
    );
  }


  Container buildTextFormFieldPassword(TextEditingController Controller,String labeltext,BoolToPassByReference ObscureText,{TextEditingController Controller2,String Function(String) Validator}) {
    if(Validator==null){
    if(Controller2==null){
      Validator=passwordValidator;
    }else{
      passwordMatchValidatorClass OtherPasswordField=passwordMatchValidatorClass(Controller2);
      Validator=OtherPasswordField.passwordMatchValidator;
    }
    }
    return Container(
        padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(5),
    child: TextFormField(
      controller: Controller,
      style: Get.theme.textTheme.bodyText1,
      validator: Validator,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: InputDecoration(
        labelText: labeltext,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            ObscureText.obscure
                ? Icons.visibility
                : Icons.visibility_off,

          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
              ObscureText.obscure = !ObscureText.obscure;
              update();
            }


        ),
      ),

      obscureText: ObscureText.obscure,
    )
    );
  }
}
