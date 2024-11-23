/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"title":"AN Basic","description":"ANBASIC","price":"3100.00","type":"3","time":"1","id":"201","user_id":"372","plan_id":"2","transaction_id":"Razorpay","status":"1","end_date":"2025-11-19","created_at":"2024-11-19 17:28:45","time_text":"1 Year","plan_type":"Yearly","t_status":"Active","start_date":"19 Nov, 2024","last_date":"19 Nov, 2025"}]

class MyPlansModel {
  MyPlansModel({
    String? responseCode,
    String? msg,
    List<PlansData>? data,
  }) {
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
  }

  MyPlansModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PlansData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<PlansData>? _data;
  MyPlansModel copyWith({
    String? responseCode,
    String? msg,
    List<PlansData>? data,
  }) =>
      MyPlansModel(
        responseCode: responseCode ?? _responseCode,
        msg: msg ?? _msg,
        data: data ?? _data,
      );
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<PlansData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "AN Basic"
/// description : "ANBASIC"
/// price : "3100.00"
/// type : "3"
/// time : "1"
/// id : "201"
/// user_id : "372"
/// plan_id : "2"
/// transaction_id : "Razorpay"
/// status : "1"
/// end_date : "2025-11-19"
/// created_at : "2024-11-19 17:28:45"
/// time_text : "1 Year"
/// plan_type : "Yearly"
/// t_status : "Active"
/// start_date : "19 Nov, 2024"
/// last_date : "19 Nov, 2025"

class PlansData {
  PlansData({
    String? title,
    String? description,
    String? price,
    String? type,
    String? time,
    String? id,
    String? userId,
    String? planId,
    String? transactionId,
    String? status,
    String? endDate,
    String? createdAt,
    String? timeText,
    String? planType,
    String? tStatus,
    String? startDate,
    String? lastDate,
  }) {
    _title = title;
    _description = description;
    _price = price;
    _type = type;
    _time = time;
    _id = id;
    _userId = userId;
    _planId = planId;
    _transactionId = transactionId;
    _status = status;
    _endDate = endDate;
    _createdAt = createdAt;
    _timeText = timeText;
    _planType = planType;
    _tStatus = tStatus;
    _startDate = startDate;
    _lastDate = lastDate;
  }

  PlansData.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _type = json['type'];
    _time = json['time'];
    _id = json['id'];
    _userId = json['user_id'];
    _planId = json['plan_id'];
    _transactionId = json['transaction_id'];
    _status = json['status'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _timeText = json['time_text'];
    _planType = json['plan_type'];
    _tStatus = json['t_status'];
    _startDate = json['start_date'];
    _lastDate = json['last_date'];
  }
  String? _title;
  String? _description;
  String? _price;
  String? _type;
  String? _time;
  String? _id;
  String? _userId;
  String? _planId;
  String? _transactionId;
  String? _status;
  String? _endDate;
  String? _createdAt;
  String? _timeText;
  String? _planType;
  String? _tStatus;
  String? _startDate;
  String? _lastDate;
  PlansData copyWith({
    String? title,
    String? description,
    String? price,
    String? type,
    String? time,
    String? id,
    String? userId,
    String? planId,
    String? transactionId,
    String? status,
    String? endDate,
    String? createdAt,
    String? timeText,
    String? planType,
    String? tStatus,
    String? startDate,
    String? lastDate,
  }) =>
      PlansData(
        title: title ?? _title,
        description: description ?? _description,
        price: price ?? _price,
        type: type ?? _type,
        time: time ?? _time,
        id: id ?? _id,
        userId: userId ?? _userId,
        planId: planId ?? _planId,
        transactionId: transactionId ?? _transactionId,
        status: status ?? _status,
        endDate: endDate ?? _endDate,
        createdAt: createdAt ?? _createdAt,
        timeText: timeText ?? _timeText,
        planType: planType ?? _planType,
        tStatus: tStatus ?? _tStatus,
        startDate: startDate ?? _startDate,
        lastDate: lastDate ?? _lastDate,
      );
  String? get title => _title;
  String? get description => _description;
  String? get price => _price;
  String? get type => _type;
  String? get time => _time;
  String? get id => _id;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get transactionId => _transactionId;
  String? get status => _status;
  String? get endDate => _endDate;
  String? get createdAt => _createdAt;
  String? get timeText => _timeText;
  String? get planType => _planType;
  String? get tStatus => _tStatus;
  String? get startDate => _startDate;
  String? get lastDate => _lastDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['type'] = _type;
    map['time'] = _time;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['transaction_id'] = _transactionId;
    map['status'] = _status;
    map['end_date'] = _endDate;
    map['created_at'] = _createdAt;
    map['time_text'] = _timeText;
    map['plan_type'] = _planType;
    map['t_status'] = _tStatus;
    map['start_date'] = _startDate;
    map['last_date'] = _lastDate;
    return map;
  }
}
