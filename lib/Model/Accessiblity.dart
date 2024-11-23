class AccessibilityModel {
  AccessibilityModel({
    required this.status,
    required this.msg,
    required this.accessibility,
  });

  final int? status;
  final String? msg;
  final List<Accessibility> accessibility;

  factory AccessibilityModel.fromJson(Map<String, dynamic> json) {
    return AccessibilityModel(
      status: json["status"],
      msg: json["msg"],
      accessibility: json["accessibility"] == null
          ? []
          : List<Accessibility>.from(
              json["accessibility"]!.map((x) => Accessibility.fromJson(x))),
    );
  }
}

class Accessibility {
  Accessibility({
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? userId;
  final String? sellerId;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final dynamic updatedAt;

  factory Accessibility.fromJson(Map<String, dynamic> json) {
    return Accessibility(
      id: json["id"],
      userId: json["user_id"],
      sellerId: json["seller_id"],
      name: json["name"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
    );
  }
}
