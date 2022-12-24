// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.name,
    required this.userNumber,
    required this.email,
    required this.phone,
    required this.address,
    this.geolocation,
    required this.password,
  });

  String name;
  String userNumber;
  String email;
  String phone;
  String address;
  String? geolocation;
  String password;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        userNumber: json["userNumber"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        geolocation: json["geolocation"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userNumber": userNumber,
        "email": email,
        "phone": phone,
        "address": address,
        "geolocation": geolocation,
        "password": password,
      };
}
