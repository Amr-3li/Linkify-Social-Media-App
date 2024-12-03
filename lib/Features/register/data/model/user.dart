// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String? id;
  String fname;
  String lname;
  String email;
  String password;
  String phone;
  String? image;
  DateTime lastActive;
  bool isPatient;
  double weight;
  double height;
  bool isMale;

//  String image;

  UserModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.phone,
    this.image,
    required this.lastActive,
    required this.isPatient,
    required this.weight,
    required this.height,
    required this.isMale,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'] ?? "",
      lastActive: DateTime.parse(json['last_active']),
      isPatient: json['isPatient'],
      weight: json['weight'],
      height: json['height'],
      isMale: json['isMale'],
      password: "",
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'image': image,
      'last_active': lastActive.toIso8601String(),
      'isPatient': isPatient,
      'weight': weight,
      'height': height,
      'isMale': isMale,
    };
  }
}
