class ProfileData {

  final String petName;
  final String petType;
  final String breed;

  ProfileData ({this.petName, this.petType, this.breed});
  bool iscompelete(){
    return petName!=""&&petType!=""&&breed!="";
  }
  Map<String, dynamic> toMap() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
    };
  }
}