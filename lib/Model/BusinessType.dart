/// message : "Data retrieved successfully"
/// status : "success"
/// data : [{"id":"1","user_id":null,"bussiness_name":"cloths bussiness"},{"id":"2","user_id":null,"bussiness_name":"wool bussiness"}]

class BusinessType {
  BusinessType({
    String? message,
    String? status,
    List<BusinessData>? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  BusinessType.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BusinessData.fromJson(v));
      });
    }
  }
  String? _message;
  String? _status;
  List<BusinessData>? _data;
  BusinessType copyWith({
    String? message,
    String? status,
    List<BusinessData>? data,
  }) =>
      BusinessType(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  String? get status => _status;
  List<BusinessData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// user_id : null
/// bussiness_name : "cloths bussiness"

class BusinessData {
  BusinessData({
    String? id,
    dynamic userId,
    String? bussinessName,
  }) {
    _id = id;
    _userId = userId;
    _bussinessName = bussinessName;
  }

  BusinessData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bussinessName = json['bussiness_name'];
  }
  String? _id;
  dynamic _userId;
  String? _bussinessName;
  BusinessData copyWith({
    String? id,
    dynamic userId,
    String? bussinessName,
  }) =>
      BusinessData(
        id: id ?? _id,
        userId: userId ?? _userId,
        bussinessName: bussinessName ?? _bussinessName,
      );
  String? get id => _id;
  dynamic get userId => _userId;
  String? get bussinessName => _bussinessName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bussiness_name'] = _bussinessName;
    return map;
  }
}
