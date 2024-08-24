/// status : true
/// message : "Success"
/// data : [{"id":1,"title":"Test ?","description":"<ul>\r\n  <li>Owl</li>\r\n  <li>Salmon</li>\r\n  <li>Tarantula</li>\r\n</ul>","created_at":"2024-06-13 19:49:30","updated_at":null},{"id":2,"title":"test 2","description":"<ul>\r\n  <li>Owl</li>\r\n  <li>Salmon</li>\r\n  <li>Tarantula</li>\r\n</ul>","created_at":"2024-06-13 19:49:30","updated_at":null}]

class FaqModel {
  FaqModel({
      bool? status, 
      String? message, 
      List<FaqData>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FaqModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FaqData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<FaqData>? _data;
FaqModel copyWith({  bool? status,
  String? message,
  List<FaqData>? data,
}) => FaqModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<FaqData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "Test ?"
/// description : "<ul>\r\n  <li>Owl</li>\r\n  <li>Salmon</li>\r\n  <li>Tarantula</li>\r\n</ul>"
/// created_at : "2024-06-13 19:49:30"
/// updated_at : null

class FaqData {
  FaqData({
      num? id, 
      String? title, 
      String? description, 
      String? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  FaqData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _createdAt;
  dynamic _updatedAt;
  FaqData copyWith({  num? id,
  String? title,
  String? description,
  String? createdAt,
  dynamic updatedAt,
}) => FaqData(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}