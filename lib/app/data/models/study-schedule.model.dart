// To parse this JSON data, do
//
//     final studyScheduleModel = studyScheduleModelFromJson(jsonString);

import 'dart:convert';

StudyScheduleModel studyScheduleModelFromJson(String str) => StudyScheduleModel.fromJson(json.decode(str));

Datum datumStudyScheduleFromJson(String str) => Datum.fromJson(json.decode(str));

String datumStudyScheduleToJson(Datum data) => json.encode(data.toJson());

String studyScheduleModelToJson(StudyScheduleModel data) => json.encode(data.toJson());

class StudyScheduleModel {
  StudyScheduleModel({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
    this.data,
  });

  int? page;
  int? limit;
  int? total;
  int? totalPage;
  List<Datum>? data;

  factory StudyScheduleModel.fromJson(Map<String, dynamic> json) => StudyScheduleModel(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPage": totalPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
     this.idStudySchedule,
     this.title,
     this.description,
     this.time,
     this.location,
     this.image,
     this.createdAt,
     this.updatedAt,
  });

  int? idStudySchedule;
  String? title;
  String? description;
  DateTime? time;
  String? location;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idStudySchedule: json["idStudySchedule"],
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        image: json["image"],
        location: json["location"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idStudySchedule": idStudySchedule,
        "title": title,
        "description": description,
        "time": time!.toIso8601String(),
        "image": image,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class StoreStudyScheduleModel {
  StoreStudyScheduleModel({
    required this.title,
    required this.description,
    required this.location,
    required this.time,
  });

  String title;
  String description;
  String location;
  String time;

  factory StoreStudyScheduleModel.fromJson(Map<String, dynamic> json) => StoreStudyScheduleModel(
        title: json["title"],
        description: json["description"],
        location: json["location"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "time": time,
      };
}
