
class ProfileData {

  final String petName;
  final String petType;
  final String breed;
  final String gender;
  final String Email;
  final String avatarUrl;


  ProfileData ({this.petName, this.petType, this.breed,this.Email,this.avatarUrl,this.gender});
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