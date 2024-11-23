/// response_code : "1"
/// message : "Venue Get Successfully"
/// status : "success"
/// data : [{"id":"2","seller_id":"372","category":"54","name":"Sandeep","mobile":"8097880000","email":"sandeep@gmail.com","image":"673d886cb1f8d.jpg","accesblity":"3,4,5,6","address":"vijay Nagar colony ","start_time":"06:27","end_time":"06:55","created_at":"2024-11-20 12:27:48","updated_at":null,"accessibility_names":"Accessible Washroom,Alternative Entrance,ASL (Sign Language),Automatic Door,Accessible Washroom,Alternative Entrance,ASL (Sign Language),Automatic Door","total_reviews":"8"},{"id":"1","seller_id":"1","category":null,"name":"test Venuees","mobile":"8987898788","email":"test2@gmail.com","image":"673d7d3e07c93.png","accesblity":"2,3","address":"test Address","start_time":"2024-10-10 19:20:00","end_time":"2024-10-10 19:20:21","created_at":"2024-11-20 11:33:26","updated_at":null,"accessibility_names":"Accessible Parking,Accessible Washroom","total_reviews":"0"}]
/// total_count : 2

class VenueListModel {
  VenueListModel({
    String? responseCode,
    String? message,
    String? status,
    List<VenueData>? data,
    num? totalCount,
  }) {
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
    _totalCount = totalCount;
  }

  VenueListModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VenueData.fromJson(v));
      });
    }
    _totalCount = json['total_count'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  List<VenueData>? _data;
  num? _totalCount;
  VenueListModel copyWith({
    String? responseCode,
    String? message,
    String? status,
    List<VenueData>? data,
    num? totalCount,
  }) =>
      VenueListModel(
        responseCode: responseCode ?? _responseCode,
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
        totalCount: totalCount ?? _totalCount,
      );
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  List<VenueData>? get data => _data;
  num? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
    return map;
  }
}

/// id : "2"
/// seller_id : "372"
/// category : "54"
/// name : "Sandeep"
/// mobile : "8097880000"
/// email : "sandeep@gmail.com"
/// image : "673d886cb1f8d.jpg"
/// accesblity : "3,4,5,6"
/// address : "vijay Nagar colony "
/// start_time : "06:27"
/// end_time : "06:55"
/// created_at : "2024-11-20 12:27:48"
/// updated_at : null
/// accessibility_names : "Accessible Washroom,Alternative Entrance,ASL (Sign Language),Automatic Door,Accessible Washroom,Alternative Entrance,ASL (Sign Language),Automatic Door"
/// total_reviews : "8"

class VenueData {
  VenueData({
    String? id,
    String? sellerId,
    String? category,
    String? name,
    String? mobile,
    String? email,
    String? image,
    String? accesblity,
    String? address,
    String? startTime,
    String? endTime,
    String? createdAt,
    dynamic updatedAt,
    String? accessibilityNames,
    String? totalReviews,
  }) {
    _id = id;
    _sellerId = sellerId;
    _category = category;
    _name = name;
    _mobile = mobile;
    _email = email;
    _image = image;
    _accesblity = accesblity;
    _address = address;
    _startTime = startTime;
    _endTime = endTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _accessibilityNames = accessibilityNames;
    _totalReviews = totalReviews;
  }

  VenueData.fromJson(dynamic json) {
    _id = json['id'];
    _sellerId = json['seller_id'];
    _category = json['category'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _image = json['image'];
    _accesblity = json['accesblity'];
    _address = json['address'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _accessibilityNames = json['accessibility_names'];
    _totalReviews = json['total_reviews'];
  }
  String? _id;
  String? _sellerId;
  String? _category;
  String? _name;
  String? _mobile;
  String? _email;
  String? _image;
  String? _accesblity;
  String? _address;
  String? _startTime;
  String? _endTime;
  String? _createdAt;
  dynamic _updatedAt;
  String? _accessibilityNames;
  String? _totalReviews;
  VenueData copyWith({
    String? id,
    String? sellerId,
    String? category,
    String? name,
    String? mobile,
    String? email,
    String? image,
    String? accesblity,
    String? address,
    String? startTime,
    String? endTime,
    String? createdAt,
    dynamic updatedAt,
    String? accessibilityNames,
    String? totalReviews,
  }) =>
      VenueData(
        id: id ?? _id,
        sellerId: sellerId ?? _sellerId,
        category: category ?? _category,
        name: name ?? _name,
        mobile: mobile ?? _mobile,
        email: email ?? _email,
        image: image ?? _image,
        accesblity: accesblity ?? _accesblity,
        address: address ?? _address,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        accessibilityNames: accessibilityNames ?? _accessibilityNames,
        totalReviews: totalReviews ?? _totalReviews,
      );
  String? get id => _id;
  String? get sellerId => _sellerId;
  String? get category => _category;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get image => _image;
  String? get accesblity => _accesblity;
  String? get address => _address;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  String? get accessibilityNames => _accessibilityNames;
  String? get totalReviews => _totalReviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['seller_id'] = _sellerId;
    map['category'] = _category;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['image'] = _image;
    map['accesblity'] = _accesblity;
    map['address'] = _address;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['accessibility_names'] = _accessibilityNames;
    map['total_reviews'] = _totalReviews;
    return map;
  }
}
