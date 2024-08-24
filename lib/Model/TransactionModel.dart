/// status : true
/// message : "success"
/// data : [{"id":3,"project_id":480,"amount":"20000","status":0,"created_at":"2024-06-27 16:00:06","updated_at":null},{"id":2,"project_id":480,"amount":"20000","status":0,"created_at":"2024-06-27 15:55:15","updated_at":null},{"id":1,"project_id":480,"amount":"10000","status":0,"created_at":"2024-06-27 15:54:45","updated_at":null}]

class TransactionModel {
  TransactionModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TransactionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
TransactionModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => TransactionModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : 3
/// project_id : 480
/// amount : "20000"
/// status : 0
/// created_at : "2024-06-27 16:00:06"
/// updated_at : null

class Data {
  Data({
      num? id, 
      num? projectId, 
      String? amount, 
      num? status, 
      String? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _projectId = projectId;
    _amount = amount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _projectId = json['project_id'];
    _amount = json['amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _projectId;
  String? _amount;
  num? _status;
  String? _createdAt;
  dynamic _updatedAt;
Data copyWith({  num? id,
  num? projectId,
  String? amount,
  num? status,
  String? createdAt,
  dynamic updatedAt,
}) => Data(  id: id ?? _id,
  projectId: projectId ?? _projectId,
  amount: amount ?? _amount,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get projectId => _projectId;
  String? get amount => _amount;
  num? get status => _status;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['project_id'] = _projectId;
    map['amount'] = _amount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}