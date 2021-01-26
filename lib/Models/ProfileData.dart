

class ProfileData {
  final String uid;
  final String petName;
  final String petType;
  final String breed;
  final String gender;
  final String email;
  final String avatarUrl;
  UserLocation location;
  List<String> swipedLeft=List<String>();
  List<String> swipedRight=List<String>();
  ProfileData ({this.petName, this.petType, this.breed,this.email,this.avatarUrl,this.gender, this.location, this.uid,this.swipedLeft,this.swipedRight}){
    if(location==null){
      location=UserLocation();
    }
  }
  bool isComplete(){
    return petName!="null"&&petType!="null"&&breed!="null"&&gender!="null"&&petName!=null&&petType!=null&&breed!=null&&gender!=null&&avatarUrl!=null;
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
  Map<String, dynamic> toMapTesting() {
    return {
      'Pet Name': petName,
      'Pet Type': petType,
      'Breed': breed,
      'Gender': gender,
      'Avatar': avatarUrl,
      'Location': location.toMap(),
      "swipedLeft":swipedLeft,
      "swipedRight":swipedRight
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

  UserLocation({this.area,this.country});

  Map<String, dynamic> toMap() {
    return {
      "Area": area,
      "Country": country
    };
  }

}