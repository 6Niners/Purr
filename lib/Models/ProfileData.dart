
class ProfileData {
  final String uid;
  final String petName;
  final String petType;
  final String breed;
  final String gender;
  final String email;
  final String avatarUrl;
  final UserLocation location;


  ProfileData ({this.petName, this.petType, this.breed,this.email,this.avatarUrl,this.gender, this.location, this.uid});
  bool isComplete(){
    return petName!="null"&&petType!="null"&&breed!="null"&&gender!="null"&&petName!=null&&petType!=null&&breed!=null&&gender!=null;
  }
  Map<String, dynamic> toMap() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
      'Gender': gender,
      'Avatar': avatarUrl,
      'Location': location.toMap(),
    };
  }
  Map<String, dynamic> toMapShowToUser() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
      'Gender': gender,
    };
  }
}


class UserLocation {

  String area;
  String country;

  UserLocation();

  Map<String, dynamic> toMap() {
    return {
      "Area": area,
      "Country": country
    };
  }

}