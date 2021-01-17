class ProfileData {

  final String petName;
  final String petType;
  final String breed;
  final String Email;
  final String avatarUrl;
  ProfileData ({this.petName, this.petType, this.breed,this.Email,this.avatarUrl});
  bool iscompelete(){
    return petName!="null"&&petType!="null"&&breed!="null"&&petName!=null&&petType!=null&&breed!=null;
  }
  Map<String, dynamic> toMap() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
      'Avatar': avatarUrl,
    };
  }
}