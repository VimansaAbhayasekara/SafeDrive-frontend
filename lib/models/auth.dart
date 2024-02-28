class Auth {
  String? email;
  String? password;
  String? role;
  String? mobile;
  String? province;
  String? district;
  String? businessLicenseNumber;

  Auth({this.email, this.password, this.role, this.province, this.district});

  Auth.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    password = json['password'];
    role = json['role'];
    mobile = json['mobile'];
    province = json['province'];
    district = json['district'];
    businessLicenseNumber = json['businessLicenseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['mobile'] = mobile;
    data['province'] = province;
    data['district'] = district;
    data['businessLicenseNumber'] = businessLicenseNumber;
    return data;
  }
}
