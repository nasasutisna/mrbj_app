// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    required this.time,
    required this.codeSholat,
    required this.userId,
  });

  int userId;
  DateTime time;
  String codeSholat;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        userId: json["userId"],
        time: DateTime.parse(json["time"]),
        codeSholat: json["codeSholat"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "time": time.toIso8601String(),
        "codeSholat": codeSholat,
      };
}


