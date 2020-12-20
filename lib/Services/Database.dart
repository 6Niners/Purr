import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference user = FirebaseFirestore.instance.collection('UserData');

  Future<void> updateUserData(String petName, String pet, int breed) async {
    return await user.doc(uid).set({
      'Pet Name': petName,
      'Pet': pet,
      'Breed': breed,
    });
  }

}