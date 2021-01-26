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
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';



bool equalsIgnoreCase(String string1, String string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();}

class RegistrationController extends GetxController {
  User firebaseUser;
  FirebaseAuth auth;
  ProfileData userInfo=ProfileData();

  List<ProfileData> users=List<ProfileData>();
  String background="assets/other.jpg";

  UserLocation userLocation = UserLocation();

  @override
  Future<void> onInit() async {
    await super.onInit();
    auth=FirebaseAuth.instance;

  }

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser = auth.currentUser;
      if(firebaseUser.emailVerified){
        if(await profileIsComplete()){
          getUsers();
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
        showToast(
            'No user found for that email.', backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showToast('Wrong password provided for that user.',
            backgroundColor: Colors.red);
      }
    }
  }


  Future<void> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await updateUserData(ProfileData(petName:"null",petType:"null",breed:"null"));
      Get.offAll(VerifyEmailPage());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is very weak');
        showToast(
            'The password provided is very weak', backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        print('This email is already in use, try to sign in instead');
        showToast('This email is already in use, try to sign in instead',
            backgroundColor: Colors.red);
      } else {
        showToast(e.message, backgroundColor: Colors.red);
      }

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showToast(
          "Reset password link has sent your mail please use it to change the password.",
          backgroundColor: Colors.blue);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        showToast(
            'There is no user with that email', backgroundColor: Colors.red);
      }
      else {
        showToast(e.message, backgroundColor: Colors.red);
      }
    }
  }

  //if the user is logged in
  Future<bool> validatePassword(String password) async {
    firebaseUser = auth.currentUser;
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

  Future<void> sendEmailVerification() async {
    firebaseUser = auth.currentUser;
    firebaseUser.sendEmailVerification();
    showToast(
        "verification email has been sent", backgroundColor: Colors.blue);
  }

  Future<void> updatePassword(String password) async {
    firebaseUser = auth.currentUser;

    firebaseUser.updatePassword(password);
    print("changed to " + password);
    showToast("Your password got changed", backgroundColor: Colors.blue);
  }

  void isEmailVerified() {
    firebaseUser = auth.currentUser;
    firebaseUser.reload();
    if (firebaseUser.emailVerified) {
      Get.offAll(SetupProfilePage());
    }
  }
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> profileIsComplete() async {
    await getUserProfileData();
    print(userInfo.toMap());
    return userInfo.isComplete();
  }
  Future checkIfLoggedIn() async {
    firebaseUser = auth.currentUser;
    if(firebaseUser!=null){
      if(firebaseUser.emailVerified){
        if(await profileIsComplete()){
          getUsers();
        Get.offAll(MainPage());
        }else{
          Get.offAll(SetupProfilePage());
        }
      }else{
        Get.offAll(VerifyEmailPage());
      }
    }
  }


  Future<void> updateUserData(ProfileData tmp) async {
    userInfo=tmp;

    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    return await user.doc(auth.currentUser.uid).set(tmp.toMap());
  }
  Future<void> addUserSwipeLeft(ProfileData tmp) async {
    FirebaseFirestore.instance.collection('UserData').doc(auth.currentUser.uid).update({
      "Swiped Left": FieldValue.arrayUnion([tmp.uid])
    });
  }
  Future<void> addUserSwipeRight(ProfileData tmp) async {
    FirebaseFirestore.instance.collection('UserData').doc(auth.currentUser.uid).update( {
      "Swiped Right": FieldValue.arrayUnion([tmp.uid])
    });
  }
  backgroundForChat() async {
    await getUserProfileData();

    if ( equalsIgnoreCase(userInfo.petType,'cat')) {
      background= "assets/wallpaper-cat.jpg";
    }

    else if ( equalsIgnoreCase(userInfo.petType,'dog')) {
      background=  "assets/dog2.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'hamster')) {
      background=  "assets/hamster.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'squirrel')) {
      background=  "assets/squirrel.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'turtle')) {
      background=  "assets/turtle1.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'rabbit')) {
      background=  "assets/rabbit.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'bird')){
      background=  "assets/bird1.jpg";  }

    else if ( equalsIgnoreCase(userInfo.petType,'parrot')){
      background=  "assets/parrot.jpg";  }

    else{
      background=  "assets/other.jpg";
    }

  }
  Future<void> getUserProfileData({String uid}) async {
    if(uid==null) {
      uid=auth.currentUser.uid;
      final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
      await user.doc(uid).get().then((document){
        if (document.exists){
          userInfo=ProfileData(petName:document.data()['Pet Name'],petType:document.data()['Pet Type'],breed:document.data()['Breed'],gender:document.data()['Gender'],avatarUrl:document.data()['Avatar']  ,email: firebaseUser.email);
        }
      });
      backgroundForChat();
      update();
    }else{
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    await user.doc(uid).get().then((document){
      if (document.exists){
        users.add(ProfileData(uid: uid,petName:document.data()['Pet Name'],petType:document.data()['Pet Type'],breed:document.data()['Breed'],gender:document.data()['Gender'],avatarUrl:document.data()['Avatar'] ));
      }
    });
    update();
    }
  }
  Future<void> getUsers() async {
    
    var usersInFirebase = await FirebaseFirestore.instance.collection('UserData').where('Pet Type', isEqualTo: userInfo.petType).where("Gender", isNotEqualTo: userInfo.gender).get();
    usersInFirebase.docs.forEach((result) {
      getUserProfileData(uid: result.id);
      //print(result.id);
    });
    update();
  }



//ui widgets to avoid repeating the same functions
  Container buildTextFormField(TextEditingController textController,String labelText,Function(String) validator) {
    return Container(
        padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(5),
    child: TextFormField(
        validator:validator,
        controller: textController,
        style: Get.theme.textTheme.bodyText1,
        autovalidateMode: AutovalidateMode.disabled,
        decoration: InputDecoration(
            labelText: labelText,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,),),
        )
    )
    );
  }


  Container buildTextFormFieldPassword(TextEditingController textController,String labelText,BoolToPassByReference obscureText,{TextEditingController textController2,String Function(String) validator}) {
    if(validator==null){
    if(textController2==null){
      validator=passwordValidator;
    }else{
      PasswordMatchValidatorClass otherPasswordField=PasswordMatchValidatorClass(textController2);
      validator=otherPasswordField.passwordMatchValidator;
    }
    }
    return Container(
        padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(5),
    child: TextFormField(
      controller: textController,
      style: Get.theme.textTheme.bodyText1,
      validator: validator,
      autovalidateMode: AutovalidateMode.disabled,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide:BorderSide( color: Get.theme.highlightColor,)),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            obscureText.obscure
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
              obscureText.obscure = !obscureText.obscure;
              update();
            }
        ),
      ),

      obscureText: obscureText.obscure,
    )
    );
  }


  Future<Position> getCurrentLocation() async {

    bool serviceEnabled = false;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services disabled", backgroundColor: Colors.red);
      return Future.error("Location services disabled");
    }


    permission = await Geolocator.checkPermission();


    if (permission == LocationPermission.deniedForever) {
      showToast('Location permissions are permanently denied, we cannot request permissions.', backgroundColor: Colors.red);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    // request location on start up when (only once location services) is selected
    if (permission == LocationPermission.denied) {

      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        showToast('Location permissions are denied (actual value: $permission).', backgroundColor: Colors.red);

        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }


    var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print( "LAT: ${location.latitude}, LNG: ${location.longitude}" );

    return location;
  }



  Future<void> getAddressFromLatLng() async {

    var location = await getCurrentLocation();

    List<Placemark> address =  await placemarkFromCoordinates(location.latitude, location.longitude);
    print("ADDRESS: ${address[0].administrativeArea}, Country: ${address[0].country}");

    userLocation.area = address[0].administrativeArea;
    userLocation.country = address[0].country;
  }



}





















