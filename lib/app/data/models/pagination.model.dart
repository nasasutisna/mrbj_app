// To parse this JSON data, do
//
//     final paginationModel = paginationModelFromJson(jsonString);

import 'dart:convert';

PaginationModel paginationModelFromJson(String str) =>
    PaginationModel.fromJson(json.decode(str));

String paginationModelToJson(PaginationModel data) =>
    json.encode(data.toJson());

class PaginationModel {
  PaginationModel({
    this.page,
    this.limit,
  });

  int? page;
  int? limit;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
      };
}
