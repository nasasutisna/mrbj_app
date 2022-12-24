// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) =>
    json.encode(data.toJson());

class AuthenticationModel {
  AuthenticationModel({
    required this.message,
    required this.data,
  });

  String message;
  User data;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        message: json["message"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class User {
  User({
    required this.name,
    required this.email,
    required this.userId,
    required this.userNumber,
    required this.accessToken,
    required this.role,
  });

  String name;
  String email;
  int userId;
  String userNumber;
  String accessToken;
  int role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        userId: json["userId"],
        accessToken: json["accessToken"],
        userNumber: json["userNumber"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "accessToken": accessToken,
        "userNumber": userNumber,
        "userId": userId,
        "role": role,
      };
}
