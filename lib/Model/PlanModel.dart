class PlanModel {
  PlanModel({
    required this.responseCode,
    required this.msg,
    required this.data,
  });

  final String? responseCode;
  final String? msg;
  final List<PlanData> data;

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      responseCode: json["response_code"],
      msg: json["msg"],
      data: json["data"] == null
          ? []
          : List<PlanData>.from(json["data"]!.map((x) => PlanData.fromJson(x))),
    );
  }
}

class PlanData {
  PlanData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.time,
    required this.type,
    required this.image,
    required this.json,
    required this.createdAt,
    required this.updatedAt,
    required this.timeText,
    required this.planType,
  });

  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final String? time;
  final String? type;
  final String? image;
  final List<Json> json;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? timeText;
  final String? planType;

  factory PlanData.fromJson(Map<String, dynamic> json) {
    return PlanData(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      time: json["time"],
      type: json["type"],
      image: json["image"],
      json: json["json"] == null
          ? []
          : List<Json>.from(json["json"]!.map((x) => Json.fromJson(x))),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      timeText: json["time_text"],
      planType: json["plan_type"],
    );
  }
}

class Json {
  Json({
    required this.title,
    required this.isTrue,
  });

  final String? title;
  final String? isTrue;

  factory Json.fromJson(Map<String, dynamic> json) {
    return Json(
      title: json["title"],
      isTrue: json["is_true"],
    );
  }
}
