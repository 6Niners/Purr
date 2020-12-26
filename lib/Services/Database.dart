import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';

class DatabaseService extends GetxController {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference user = FirebaseFirestore.instance.collection('UserData');

  Future<void> updateUserData(String petName, String pet, String breed) async {
    // final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    return await user.doc(uid).set({
      'Pet Name': petName,
      'Pet': pet,
      'Breed': breed,
    });
  }



  List<ProfileData> _returnProfileDataListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((streamDoc){
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
}