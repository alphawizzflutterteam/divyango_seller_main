class GetCity {
  GetCity({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final List<CityData> data;

  factory GetCity.fromJson(Map<String, dynamic> json){
    return GetCity(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<CityData>.from(json["data"]!.map((x) => CityData.fromJson(x))),
    );
  }

}

class CityData {
  CityData({
    required this.id,
    required this.city,
    required this.address,
    required this.aId,
    required this.delete,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? city;
  final String? address;
  final int? aId;
  final int? delete;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CityData.fromJson(Map<String, dynamic> json){
    return CityData(
      id: json["id"],
      city: json["city"],
      address: json["address"],
      aId: json["a_id"],
      delete: json["delete"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
