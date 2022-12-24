// To parse this JSON data, do
//
//     final userAttendanceModel = userAttendanceModelFromJson(jsonString);

import 'dart:convert';

List<UserAttendanceModel> userAttendanceModelFromJson(String str) =>
    List<UserAttendanceModel>.from(json.decode(str).map((x) => UserAttendanceModel.fromJson(x)));

String userAttendanceModelToJson(List<UserAttendanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAttendanceModel {
  UserAttendanceModel({
    required this.userDetail,
    required this.id,
    required this.fullName,
    required this.subuh,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  UserDetail userDetail;
  int id;
  String fullName;
  int subuh;
  int dzuhur;
  int ashar;
  int maghrib;
  int isya;

  factory UserAttendanceModel.fromJson(Map<String, dynamic> json) => UserAttendanceModel(
        userDetail: UserDetail.fromJson(json["userDetail"]),
        id: json["id"],
        fullName: json["fullName"],
        subuh: json["subuh"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
      );

  Map<String, dynamic> toJson() => {
        "userDetail": userDetail.toJson(),
        "id": id,
        "fullName": fullName,
        "subuh": subuh,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
      };
}

class UserDetail {
  UserDetail({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.geolocation,
  });

  int userId;
  String name;
  String email;
  String phone;
  String address;
  String geolocation;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        geolocation: json["geolocation"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "geolocation": geolocation == '' ? null : geolocation,
      };
}
