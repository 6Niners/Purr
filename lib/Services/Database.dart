import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';

class DatabaseService extends GetxController {
  final String uid;

  String userEmail = "PlaceHolder@email.com";
  List<String> profileData = ["PlaceHolder", "PlaceHolder", "PlaceHolder"];


  DatabaseService({this.uid});

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference user = FirebaseFirestore.instance.collection('UserData');


  Future<void> updateUserData(String petName, String pet, String breed) async {
    // final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    return await user.doc(uid).set({
      'Pet Name': petName,
      'Pet': pet,
      'Breed': breed,
    });
  }



  Future<void> getUserProfileData() async {

    await user.doc(firebaseUser.uid).get().then((document){

      if (document.exists){
        profileData.clear();

        userEmail = firebaseUser.email;

        document.data().forEach((key, value) {
          profileData.add(value);
        });
      }
    });

    update();
  }




  /*
  List<ProfileData> _returnProfileDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((streamDoc) {
      return ProfileData(
        petName: streamDoc.data()["Pet Name"],
        pet: streamDoc.data()["Pet"],
        breed: streamDoc.data()["Breed"],
      );
    }).toList();
  }

  Stream<List<ProfileData>> get userData {
    return user.snapshots().map(_returnProfileDataListFromSnapshot);
  }
  */
}