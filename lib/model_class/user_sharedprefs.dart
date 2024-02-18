
class User {
  String? name;
  String? email;
  String? password;
  String? mobileNumber;
  String? dateOfBirth;
  String? country;
  String? state;
  String? city;
  List<String>? hobbies;
  String? gender;

User(
    {required this.name,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.dateOfBirth,
      required this.country,
      required this.city,
      required this.state,
      this.hobbies,
      required this.gender});

Map<String, dynamic> toJson() {
  return {
    'fullName': name,
    'email': email,
    'password': password,
    'mobileNumber': mobileNumber,
    'dateOfBirth': dateOfBirth,
    'country': country,
    'city': city,
    'gender': gender,
    'state': state,
    'hobbies': hobbies
  };
}

User.fromJson(Map<String , dynamic> json){
name = json['Name'];
email = json['Email'];
password = json['Password'];
mobileNumber = json['Mobile Number'];
dateOfBirth = json['Date of birth'];
country = json['Country'];
city = json['City'];
gender = json['gender'];
state = json['State'];
hobbies = (json['Hobbies'] as List<dynamic>).cast<String>();

}
}