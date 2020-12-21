import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseService extends GetxController {

  final String uid;
  DatabaseService({ this.uid });

  //final CollectionReference user = FirebaseFirestore.instance.collection('UserData');

  Future<void> updateUserData(String petName, String pet, String breed) async {
    final CollectionReference user = FirebaseFirestore.instance.collection('UserData');
    return await user.doc(uid).set({
      'Pet Name': petName,
      'Pet': pet,
      'Breed': breed,
    });
  }

}