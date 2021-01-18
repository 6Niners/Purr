
class ProfileData {
  final String uid;
  final String petName;
  final String petType;
  final String breed;
  final String gender;
  final String email;
  final String avatarUrl;


  ProfileData ({this.petName, this.petType, this.breed,this.email,this.avatarUrl,this.gender,this.uid});
  bool iscompelete(){
    return petName!="null"&&petType!="null"&&breed!="null"&&gender!="null"&&petName!=null&&petType!=null&&breed!=null&&gender!=null;
  }
  Map<String, dynamic> toMap() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
      'Gender': gender,
      'Avatar': avatarUrl,
    };
  }
}