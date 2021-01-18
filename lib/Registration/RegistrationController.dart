import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purr/MainPage/MainPage.dart';
import 'package:purr/Models/ProfileData.dart';
import 'package:purr/Registration/CommonClasses-functions.dart';
import 'package:purr/Registration/SetupProfile.dart';
import 'package:purr/Registration/VerifyMail.dart';
import 'package:purr/UI_Widgets.dart';

bool equalsIgnoreCase(String string1, String string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();}

class RegistrationController extends GetxController {
  User firebaseUser;
  FirebaseAuth Auth;
  ProfileData UserInfo=ProfileData();

  List<ProfileData> users=List<ProfileData>();
  String Background="assets/other.jpg";

  @override
  Future<void> onInit() async {
    Auth=FirebaseAuth.instance;
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await Auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = Auth.currentUser;
      if(firebaseUser.emailVerified){
        if(await profileiscomplete()){
          GetUsers();
          Get.offAll(MainPage());
        }else{
          Get.offAll(SetupProfilePage());
        }
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
      await Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await updateUserData(ProfileData(petName:"null",petType:"null",breed:"null"));
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
      await Auth.sendPasswordResetEmail(email: email);
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
    firebaseUser = Auth.currentUser;
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
    firebaseUser = Auth.currentUser;
    firebaseUser.sendEmailVerification();
    ShowToast(
        "verification email has been sent", Background_color: Colors.blue);
  }

  Future<void> updatePassword(String password) async {
    firebaseUser = Auth.currentUser;

    firebaseUser.updatePassword(password);
    print("changed to " + password);
    ShowToast("Your password got changed", Background_color: Colors.blue);
  }

  void ismailverified() {
    firebaseUser = Auth.currentUser;
    firebaseUser.reload();
    if (firebaseUser.emailVerified) {
      Get.offAll(SetupProfilePage());
    }
  }
  Future signOut() async {
    try {
      return await Auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> profileiscomplete() async {
    await getUserProfileData();
    print(UserInfo.toMap());
    return UserInfo.iscompelete();
  }
  Future Checkifloggedin() async {
    firebaseUser = Auth.currentUser;
    if(firebaseUser!=null){
      if(firebaseUser.emailVerified){
        if(await profileiscomplete()){
          GetUsers();
        Get.offAll(MainPage());
        }else{
          Get.offAll(SetupProfilePage());
        }
      }else{
        Get.offAll(VerifyEmailPage());
      }
    }
  }


  Future<void> updateUserData(ProfileData TMP) async {
    UserInfo=TMP;
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    return await user.doc(Auth.currentUser.uid).set(TMP.toMap());
  }

  BackgroundForChat() async {
    await getUserProfileData();

    if ( equalsIgnoreCase(UserInfo.petType,'cat')) {
      Background= "assets/wallpaper-cat.jpg";
    }

    else if ( equalsIgnoreCase(UserInfo.petType,'dog')) {
      Background=  "assets/dog2.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'hamster')) {
      Background=  "assets/hamster.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'squirrel')) {
      Background=  "assets/squirrel.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'turtle')) {
      Background=  "assets/turtle1.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'rabbit')) {
      Background=  "assets/rabbit.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'bird')){
      Background=  "assets/bird1.jpg";  }

    else if ( equalsIgnoreCase(UserInfo.petType,'parrot')){
      Background=  "assets/parrot.jpg";  }

    else{
      Background=  "assets/other.jpg";
    }

  }
  Future<void> getUserProfileData({String UID}) async {
    firebaseUser = Auth.currentUser;
    if(UID==null) {
      UID=firebaseUser.uid;
      final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
      await user.doc(UID).get().then((document){
        if (document.exists){
          UserInfo=ProfileData(petName:document.data()['Pet Name'],petType:document.data()['Pet Type'],breed:document.data()['Breed'],gender:document.data()['Gender'],avatarUrl:document.data()['Avatar']  ,email: firebaseUser.email);
        }
      });
      BackgroundForChat();
      update();
    }else{
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    await user.doc(UID).get().then((document){
      if (document.exists){
        users.add(ProfileData(uid: UID,petName:document.data()['Pet Name'],petType:document.data()['Pet Type'],breed:document.data()['Breed'],gender:document.data()['Gender'],avatarUrl:document.data()['Avatar'] ));
      }
    });
    update();
    }
  }
  Future<void> GetUsers() async {
    var usersInFirebase = await FirebaseFirestore.instance.collection('UserData').where('Pet Type', isEqualTo: UserInfo.petType).where("Gender", isNotEqualTo: UserInfo.gender).get();
    usersInFirebase.docs.forEach((result) {
      getUserProfileData(UID: result.id);
      //print(result.id);
    });
    update();
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
