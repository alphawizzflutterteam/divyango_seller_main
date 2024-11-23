class GetCategory {
  GetCategory({
    required this.status,
    required this.msg,
    required this.categories,
  });

  final int? status;
  final String? msg;
  final List<Map<String, String>> categories;

  factory GetCategory.fromJson(Map<String, dynamic> json) {
    return GetCategory(
      status: json["status"],
      msg: json["msg"],
      categories: json["categories"] == null
          ? []
          : List<Map<String, String>>.from(json["categories"]!.map((x) =>
              Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
    );
  }
}
