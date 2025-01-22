// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String? id;
  String fname;
  String lname;
  String email;
  String password;
  String phone;
  String? image;
  bool isMale;
  bool isActive;

//  String image;

  UserModel(
      {this.id,
      required this.fname,
      required this.lname,
      required this.email,
      required this.password,
      required this.phone,
      this.image,
      required this.isMale,
      required this.isActive});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json['fname'] ?? "",
      lname: json['lname'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
      password: "",
      id: json['id'] ?? "",
      isMale: json['isMale'] ?? "",
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'image': image,
      'isMale': isMale,
      'isActive': isActive,
    };
  }
}
