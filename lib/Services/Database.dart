import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:purr/Models/ProfileData.dart';

class DatabaseService extends GetxController {
  final String uid;

  List<String> profileData = List();


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

        document.data().forEach((key, value) {
          profileData.add(value);
        });
      }
    });

    update();
  }


  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){

    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
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