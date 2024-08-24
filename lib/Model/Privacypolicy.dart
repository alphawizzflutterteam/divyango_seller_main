/// status : true
/// message : "Success"
/// data : {"id":1,"title":"Privacy Policy","slug":"privacy_policy","description":"<ul>\r\n  <li data-animal-type=\"bird\">Owl</li>\r\n  <li data-animal-type=\"fish\">Salmon</li>\r\n  <li data-animal-type=\"spider\">Tarantula</li>\r\n</ul>","created_at":"2024-06-13 12:18:54","update_at":null}

class Privacypolicy {
  Privacypolicy({
      bool? status, 
      String? message,
    PrivacyData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  Privacypolicy.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? PrivacyData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  PrivacyData? _data;
Privacypolicy copyWith({  bool? status,
  String? message,
  PrivacyData? data,
}) => Privacypolicy(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  PrivacyData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 1
/// title : "Privacy Policy"
/// slug : "privacy_policy"
/// description : "<ul>\r\n  <li data-animal-type=\"bird\">Owl</li>\r\n  <li data-animal-type=\"fish\">Salmon</li>\r\n  <li data-animal-type=\"spider\">Tarantula</li>\r\n</ul>"
/// created_at : "2024-06-13 12:18:54"
/// update_at : null

class PrivacyData {
  PrivacyData({
      num? id, 
      String? title, 
      String? slug, 
      String? description, 
      String? createdAt, 
      dynamic updateAt,}){
    _id = id;
    _title = title;
    _slug = slug;
    _description = description;
    _createdAt = createdAt;
    _updateAt = updateAt;
}

  PrivacyData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
  }
  num? _id;
  String? _title;
  String? _slug;
  String? _description;
  String? _createdAt;
  dynamic _updateAt;
  PrivacyData copyWith({  num? id,
  String? title,
  String? slug,
  String? description,
  String? createdAt,
  dynamic updateAt,
}) => PrivacyData(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
);
  num? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get description => _description;
  String? get createdAt => _createdAt;
  dynamic get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    return map;
  }

}