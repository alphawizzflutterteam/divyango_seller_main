/// response_code : "1"
/// message : "Vendor Found"
/// user : {"country":null,"state":null,"id":"370","fname":"","lname":"","email":"divyanshdewda2003@gmail.com","confirm_password":"12345678","bussiness_name":"test bussiness123","type_of_bussiness":"test bussiness type","bussiness_contact":"8547896541","country_code":null,"mobile":"9874563212","address":"test address123","country_id":null,"state_id":"0","city_id":null,"dob":null,"category_id":null,"subcategory_id":null,"postal_code":null,"payment_details":null,"lat":"0","lang":"0","uname":"testalphaji","password":"$2y$10$JQ0YW7qsFerIleD.KwroFeaZ1iDnU04xC6mq/oSWfOrrMK6HIvY5y","profile_image":"","device_token":"","otp":"4282","facebook_id":null,"type":null,"status":"0","wallet":"0.00","balance":"0.00","json_data":null,"last_login":null,"created_at":"2024-11-18 16:20:28","updated_at":"2024-11-18 18:49:27"}
/// active_plan : "0"
/// status : "success"

class GetProfileModel {
  GetProfileModel({
      String? responseCode, 
      String? message, 
      User? user, 
      String? activePlan, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _user = user;
    _activePlan = activePlan;
    _status = status;
}

  GetProfileModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _activePlan = json['active_plan'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  User? _user;
  String? _activePlan;
  String? _status;
GetProfileModel copyWith({  String? responseCode,
  String? message,
  User? user,
  String? activePlan,
  String? status,
}) => GetProfileModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  user: user ?? _user,
  activePlan: activePlan ?? _activePlan,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  User? get user => _user;
  String? get activePlan => _activePlan;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['active_plan'] = _activePlan;
    map['status'] = _status;
    return map;
  }

}

/// country : null
/// state : null
/// id : "370"
/// fname : ""
/// lname : ""
/// email : "divyanshdewda2003@gmail.com"
/// confirm_password : "12345678"
/// bussiness_name : "test bussiness123"
/// type_of_bussiness : "test bussiness type"
/// bussiness_contact : "8547896541"
/// country_code : null
/// mobile : "9874563212"
/// address : "test address123"
/// country_id : null
/// state_id : "0"
/// city_id : null
/// dob : null
/// category_id : null
/// subcategory_id : null
/// postal_code : null
/// payment_details : null
/// lat : "0"
/// lang : "0"
/// uname : "testalphaji"
/// password : "$2y$10$JQ0YW7qsFerIleD.KwroFeaZ1iDnU04xC6mq/oSWfOrrMK6HIvY5y"
/// profile_image : ""
/// device_token : ""
/// otp : "4282"
/// facebook_id : null
/// type : null
/// status : "0"
/// wallet : "0.00"
/// balance : "0.00"
/// json_data : null
/// last_login : null
/// created_at : "2024-11-18 16:20:28"
/// updated_at : "2024-11-18 18:49:27"

class User {
  User({
      dynamic country, 
      dynamic state, 
      String? id, 
      String? fname, 
      String? lname, 
      String? email, 
      String? confirmPassword, 
      String? bussinessName, 
      String? typeOfBussiness, 
      String? bussinessContact, 
      dynamic countryCode, 
      String? mobile, 
      String? address, 
      dynamic countryId, 
      String? stateId, 
      dynamic cityId, 
      dynamic dob, 
      dynamic categoryId, 
      dynamic subcategoryId, 
      dynamic postalCode, 
      dynamic paymentDetails, 
      String? lat, 
      String? lang, 
      String? uname, 
      String? password, 
      String? profileImage, 
      String? deviceToken, 
      String? otp, 
      dynamic facebookId, 
      dynamic type, 
      String? status, 
      String? wallet, 
      String? balance, 
      dynamic jsonData, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt,}){
    _country = country;
    _state = state;
    _id = id;
    _fname = fname;
    _lname = lname;
    _email = email;
    _confirmPassword = confirmPassword;
    _bussinessName = bussinessName;
    _typeOfBussiness = typeOfBussiness;
    _bussinessContact = bussinessContact;
    _countryCode = countryCode;
    _mobile = mobile;
    _address = address;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _dob = dob;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _postalCode = postalCode;
    _paymentDetails = paymentDetails;
    _lat = lat;
    _lang = lang;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _facebookId = facebookId;
    _type = type;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _jsonData = jsonData;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _country = json['country'];
    _state = json['state'];
    _id = json['id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _email = json['email'];
    _confirmPassword = json['confirm_password'];
    _bussinessName = json['bussiness_name'];
    _typeOfBussiness = json['type_of_bussiness'];
    _bussinessContact = json['bussiness_contact'];
    _countryCode = json['country_code'];
    _mobile = json['mobile'];
    _address = json['address'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _dob = json['dob'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _postalCode = json['postal_code'];
    _paymentDetails = json['payment_details'];
    _lat = json['lat'];
    _lang = json['lang'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _facebookId = json['facebook_id'];
    _type = json['type'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _jsonData = json['json_data'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  dynamic _country;
  dynamic _state;
  String? _id;
  String? _fname;
  String? _lname;
  String? _email;
  String? _confirmPassword;
  String? _bussinessName;
  String? _typeOfBussiness;
  String? _bussinessContact;
  dynamic _countryCode;
  String? _mobile;
  String? _address;
  dynamic _countryId;
  String? _stateId;
  dynamic _cityId;
  dynamic _dob;
  dynamic _categoryId;
  dynamic _subcategoryId;
  dynamic _postalCode;
  dynamic _paymentDetails;
  String? _lat;
  String? _lang;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  String? _otp;
  dynamic _facebookId;
  dynamic _type;
  String? _status;
  String? _wallet;
  String? _balance;
  dynamic _jsonData;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  dynamic country,
  dynamic state,
  String? id,
  String? fname,
  String? lname,
  String? email,
  String? confirmPassword,
  String? bussinessName,
  String? typeOfBussiness,
  String? bussinessContact,
  dynamic countryCode,
  String? mobile,
  String? address,
  dynamic countryId,
  String? stateId,
  dynamic cityId,
  dynamic dob,
  dynamic categoryId,
  dynamic subcategoryId,
  dynamic postalCode,
  dynamic paymentDetails,
  String? lat,
  String? lang,
  String? uname,
  String? password,
  String? profileImage,
  String? deviceToken,
  String? otp,
  dynamic facebookId,
  dynamic type,
  String? status,
  String? wallet,
  String? balance,
  dynamic jsonData,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
}) => User(  country: country ?? _country,
  state: state ?? _state,
  id: id ?? _id,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  email: email ?? _email,
  confirmPassword: confirmPassword ?? _confirmPassword,
  bussinessName: bussinessName ?? _bussinessName,
  typeOfBussiness: typeOfBussiness ?? _typeOfBussiness,
  bussinessContact: bussinessContact ?? _bussinessContact,
  countryCode: countryCode ?? _countryCode,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  dob: dob ?? _dob,
  categoryId: categoryId ?? _categoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  postalCode: postalCode ?? _postalCode,
  paymentDetails: paymentDetails ?? _paymentDetails,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  facebookId: facebookId ?? _facebookId,
  type: type ?? _type,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  jsonData: jsonData ?? _jsonData,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  dynamic get country => _country;
  dynamic get state => _state;
  String? get id => _id;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get email => _email;
  String? get confirmPassword => _confirmPassword;
  String? get bussinessName => _bussinessName;
  String? get typeOfBussiness => _typeOfBussiness;
  String? get bussinessContact => _bussinessContact;
  dynamic get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get address => _address;
  dynamic get countryId => _countryId;
  String? get stateId => _stateId;
  dynamic get cityId => _cityId;
  dynamic get dob => _dob;
  dynamic get categoryId => _categoryId;
  dynamic get subcategoryId => _subcategoryId;
  dynamic get postalCode => _postalCode;
  dynamic get paymentDetails => _paymentDetails;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  String? get otp => _otp;
  dynamic get facebookId => _facebookId;
  dynamic get type => _type;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  dynamic get jsonData => _jsonData;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['state'] = _state;
    map['id'] = _id;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['confirm_password'] = _confirmPassword;
    map['bussiness_name'] = _bussinessName;
    map['type_of_bussiness'] = _typeOfBussiness;
    map['bussiness_contact'] = _bussinessContact;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['dob'] = _dob;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['postal_code'] = _postalCode;
    map['payment_details'] = _paymentDetails;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['facebook_id'] = _facebookId;
    map['type'] = _type;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['json_data'] = _jsonData;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}