class UserModel {
  String? empId;
  String? name;
  String? email;
  String? role;
  String? city;
  String? country;
  String? phone;

  UserModel(
      {this.empId,
      this.name,
      this.email,
      this.role,
      this.city,
      this.country,
      this.phone});

  Map<String, dynamic> toJson() => {
        'employeeId': empId,
        'name': name,
        'email': email,
        'role': role,
        'city': city,
        'country': country,
        'phone': phone
      };

  UserModel.fromJson(Map<String, dynamic> json) {
    empId = json['employeeId'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    city = json['city'];
    country = json['country'];
    phone = json['phone'];
  }
}

class LoginUserModel {
  LoginUserModel({
    this.userEmail,
    this.userPassword,
  });

  String? userEmail;
  String? userPassword;

  Map<String, dynamic> toJson() => {
        "email": userEmail,
        "password": userPassword,
      };

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['email'];
    userPassword = json['password'];
  }
}
