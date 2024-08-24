/// status : true
/// message : "Success"
/// data : {"id":548,"lead_id":0,"project_name":"Digi","project_code":null,"project_short_name":null,"address":"indore vijay nagar","cp_name":"Shivani","cp_email":"Shivani@gmail.com","cp_mobile":"8097000800","gst_no":"stet36457767778","gst_name":"Testesaes","tan_no":null,"gst_percentage":0,"service_charge_incl_gst":0,"logo":"https://dberp.developmentalphawizz.com/public/files/project-logo/651.png","city":"6","is_active":2,"password":null,"a_id":2,"delete":0,"otp":4784,"created_at":"2024-06-13 11:21:30","updated_at":"2024-06-13 12:44:18"}

class GetProfileModel {
  GetProfileModel({
      bool? status, 
      String? message,
    ProfileData? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  ProfileData? _data;
GetProfileModel copyWith({  bool? status,
  String? message,
  ProfileData? data,
}) => GetProfileModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  ProfileData? get data => _data;

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

/// id : 548
/// lead_id : 0
/// project_name : "Digi"
/// project_code : null
/// project_short_name : null
/// address : "indore vijay nagar"
/// cp_name : "Shivani"
/// cp_email : "Shivani@gmail.com"
/// cp_mobile : "8097000800"
/// gst_no : "stet36457767778"
/// gst_name : "Testesaes"
/// tan_no : null
/// gst_percentage : 0
/// service_charge_incl_gst : 0
/// logo : "https://dberp.developmentalphawizz.com/public/files/project-logo/651.png"
/// city : "6"
/// is_active : 2
/// password : null
/// a_id : 2
/// delete : 0
/// otp : 4784
/// created_at : "2024-06-13 11:21:30"
/// updated_at : "2024-06-13 12:44:18"

class ProfileData {
  ProfileData({
      num? id, 
      num? leadId, 
      String? projectName, 
      dynamic projectCode, 
      dynamic projectShortName, 
      String? address, 
      String? cpName, 
      String? cpEmail, 
      String? cpMobile, 
      String? gstNo, 
      String? gstName, 
      dynamic tanNo, 
      num? gstPercentage, 
      num? serviceChargeInclGst, 
      String? logo, 
      String? city, 
      num? isActive, 
      dynamic password, 
      num? aId, 
      num? delete, 
      num? otp, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _leadId = leadId;
    _projectName = projectName;
    _projectCode = projectCode;
    _projectShortName = projectShortName;
    _address = address;
    _cpName = cpName;
    _cpEmail = cpEmail;
    _cpMobile = cpMobile;
    _gstNo = gstNo;
    _gstName = gstName;
    _tanNo = tanNo;
    _gstPercentage = gstPercentage;
    _serviceChargeInclGst = serviceChargeInclGst;
    _logo = logo;
    _city = city;
    _isActive = isActive;
    _password = password;
    _aId = aId;
    _delete = delete;
    _otp = otp;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  ProfileData.fromJson(dynamic json) {
    _id = json['id'];
    _leadId = json['lead_id'];
    _projectName = json['project_name'];
    _projectCode = json['project_code'];
    _projectShortName = json['project_short_name'];
    _address = json['address'];
    _cpName = json['cp_name'];
    _cpEmail = json['cp_email'];
    _cpMobile = json['cp_mobile'];
    _gstNo = json['gst_no'];
    _gstName = json['gst_name'];
    _tanNo = json['tan_no'];
    _gstPercentage = json['gst_percentage'];
    _serviceChargeInclGst = json['service_charge_incl_gst'];
    _logo = json['logo'];
    _city = json['city'];
    _isActive = json['is_active'];
    _password = json['password'];
    _aId = json['a_id'];
    _delete = json['delete'];
    _otp = json['otp'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _leadId;
  String? _projectName;
  dynamic _projectCode;
  dynamic _projectShortName;
  String? _address;
  String? _cpName;
  String? _cpEmail;
  String? _cpMobile;
  String? _gstNo;
  String? _gstName;
  dynamic _tanNo;
  num? _gstPercentage;
  num? _serviceChargeInclGst;
  String? _logo;
  String? _city;
  num? _isActive;
  dynamic _password;
  num? _aId;
  num? _delete;
  num? _otp;
  String? _createdAt;
  String? _updatedAt;
  ProfileData copyWith({  num? id,
  num? leadId,
  String? projectName,
  dynamic projectCode,
  dynamic projectShortName,
  String? address,
  String? cpName,
  String? cpEmail,
  String? cpMobile,
  String? gstNo,
  String? gstName,
  dynamic tanNo,
  num? gstPercentage,
  num? serviceChargeInclGst,
  String? logo,
  String? city,
  num? isActive,
  dynamic password,
  num? aId,
  num? delete,
  num? otp,
  String? createdAt,
  String? updatedAt,
}) => ProfileData(  id: id ?? _id,
  leadId: leadId ?? _leadId,
  projectName: projectName ?? _projectName,
  projectCode: projectCode ?? _projectCode,
  projectShortName: projectShortName ?? _projectShortName,
  address: address ?? _address,
  cpName: cpName ?? _cpName,
  cpEmail: cpEmail ?? _cpEmail,
  cpMobile: cpMobile ?? _cpMobile,
  gstNo: gstNo ?? _gstNo,
  gstName: gstName ?? _gstName,
  tanNo: tanNo ?? _tanNo,
  gstPercentage: gstPercentage ?? _gstPercentage,
  serviceChargeInclGst: serviceChargeInclGst ?? _serviceChargeInclGst,
  logo: logo ?? _logo,
  city: city ?? _city,
  isActive: isActive ?? _isActive,
  password: password ?? _password,
  aId: aId ?? _aId,
  delete: delete ?? _delete,
  otp: otp ?? _otp,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get leadId => _leadId;
  String? get projectName => _projectName;
  dynamic get projectCode => _projectCode;
  dynamic get projectShortName => _projectShortName;
  String? get address => _address;
  String? get cpName => _cpName;
  String? get cpEmail => _cpEmail;
  String? get cpMobile => _cpMobile;
  String? get gstNo => _gstNo;
  String? get gstName => _gstName;
  dynamic get tanNo => _tanNo;
  num? get gstPercentage => _gstPercentage;
  num? get serviceChargeInclGst => _serviceChargeInclGst;
  String? get logo => _logo;
  String? get city => _city;
  num? get isActive => _isActive;
  dynamic get password => _password;
  num? get aId => _aId;
  num? get delete => _delete;
  num? get otp => _otp;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['lead_id'] = _leadId;
    map['project_name'] = _projectName;
    map['project_code'] = _projectCode;
    map['project_short_name'] = _projectShortName;
    map['address'] = _address;
    map['cp_name'] = _cpName;
    map['cp_email'] = _cpEmail;
    map['cp_mobile'] = _cpMobile;
    map['gst_no'] = _gstNo;
    map['gst_name'] = _gstName;
    map['tan_no'] = _tanNo;
    map['gst_percentage'] = _gstPercentage;
    map['service_charge_incl_gst'] = _serviceChargeInclGst;
    map['logo'] = _logo;
    map['city'] = _city;
    map['is_active'] = _isActive;
    map['password'] = _password;
    map['a_id'] = _aId;
    map['delete'] = _delete;
    map['otp'] = _otp;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}