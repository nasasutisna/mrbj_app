import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());
FeedbackListModel feedbackListModelFromJson(String str) =>
    FeedbackListModel.fromJson(json.decode(str));
String feedbackListModelToJson(FeedbackListModel data) =>
    json.encode(data.toJson());

class FeedbackModel {
  FeedbackModel({
    required this.department,
    required this.review,
  });

  String department;
  String review;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        department: json["department"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "review": review,
      };
}

class FeedbackListModel {
  FeedbackListModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
    required this.data,
  });

  int page;
  int limit;
  int total;
  int totalPage;
  List<DataFeedback> data;

  factory FeedbackListModel.fromJson(Map<String, dynamic> json) =>
      FeedbackListModel(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
        data: List<DataFeedback>.from(
            json["data"].map((x) => DataFeedback.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPage": totalPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataFeedback {
  DataFeedback({
    required this.id,
    required this.department,
    required this.review,
  });

  int id;
  String department;
  String review;

  factory DataFeedback.fromJson(Map<String, dynamic> json) => DataFeedback(
        id: json["id"],
        department: json["department"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department": department,
        "review": review,
      };
}
