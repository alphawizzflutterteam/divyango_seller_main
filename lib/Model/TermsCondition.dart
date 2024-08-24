/// status : true
/// message : "Success"
/// data : {"id":2,"title":"Terms And Condition","slug":"terms_ans_condition","description":"<ul>\r\n  <li data-animal-type=\"bird\">Owl</li>\r\n  <li data-animal-type=\"fish\">Salmon</li>\r\n  <li data-animal-type=\"spider\">Tarantula</li>\r\n</ul>","created_at":"2024-06-13 12:18:54","update_at":null}

class TermsCondition {
  TermsCondition({
      bool? status, 
      String? message,
    TermsData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TermsCondition.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? TermsData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  TermsData? _data;
TermsCondition copyWith({  bool? status,
  String? message,
  TermsData? data,
}) => TermsCondition(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  TermsData? get data => _data;

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

/// id : 2
/// title : "Terms And Condition"
/// slug : "terms_ans_condition"
/// description : "<ul>\r\n  <li data-animal-type=\"bird\">Owl</li>\r\n  <li data-animal-type=\"fish\">Salmon</li>\r\n  <li data-animal-type=\"spider\">Tarantula</li>\r\n</ul>"
/// created_at : "2024-06-13 12:18:54"
/// update_at : null

class TermsData {
  TermsData({
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

  TermsData.fromJson(dynamic json) {
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
  TermsData copyWith({  num? id,
  String? title,
  String? slug,
  String? description,
  String? createdAt,
  dynamic updateAt,
}) => TermsData(  id: id ?? _id,
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