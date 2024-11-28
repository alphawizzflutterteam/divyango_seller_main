// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String responseCode;
  String message;
  String status;
  List<ReviewData> data;
  String totalCount;
  int accessiblePercentage;
  int partiallyAccessiblePercentage;
  int notAccessiblePercentage;

  ReviewModel({
    required this.responseCode,
    required this.message,
    required this.status,
    required this.data,
    required this.totalCount,
    required this.accessiblePercentage,
    required this.notAccessiblePercentage,
    required this.partiallyAccessiblePercentage
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        responseCode: json["response_code"],
        message: json["message"],
        status: json["status"],
        data: List<ReviewData>.from(
            json["data"].map((x) => ReviewData.fromJson(x))),
        totalCount: json["total_count"],
        accessiblePercentage: json["accessible_percentage"],
        partiallyAccessiblePercentage: json["partially_accessible_percentage"],
        notAccessiblePercentage: json["not_accessible_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total_count": totalCount,
        "partially_accessible_percentage": partiallyAccessiblePercentage,
        "not_accessible_percentage": notAccessiblePercentage,
        "accessible_percentage": accessiblePercentage,
      };
}

class ReviewData {
  String revId;
  String revUser;
  String revVenue;
  // String revStars;
  String revText;
  String revDate;
  DateTime createdAt;
  String username;
  String profilePic;

  ReviewData({
    required this.revId,
    required this.revUser,
    required this.revVenue,
    // required this.revStars,
    required this.revText,
    required this.revDate,
    required this.createdAt,
    required this.username,
    required this.profilePic,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        revId: json["rev_id"],
        revUser: json["rev_user"],
        revVenue: json["rev_venue"],
        // revStars: json["rev_stars"],
        revText: json["rev_text"],
        revDate: json["rev_date"],
        createdAt: DateTime.parse(json["created_at"]),
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "rev_id": revId,
        "rev_user": revUser,
        "rev_venue": revVenue,
        // "rev_stars": revStars,
        "rev_text": revText,
        "rev_date": revDate,
        "created_at": createdAt.toIso8601String(),
        "username": username,
        "profile_pic": profilePic,
      };
}
