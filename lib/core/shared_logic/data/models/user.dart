// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String? id;
  String name;

  String email;
  String password;
  String phone;
  String? image;
  bool isMale;
  bool isActive;

//  String image;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      this.image,
      required this.isMale,
      required this.isActive});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
      password: "",
      id: json['uid'] ?? "",
      isMale: json['isMale'] ?? "",
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'isMale': isMale,
      'isActive': isActive,
    };
  }
}
