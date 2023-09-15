class FarmerModel {
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? password;
  String? confirmPassword;
  String? phone;

  String? email;

  FarmerModel({
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.password,
    this.confirmPassword,
    this.phone,
    this.email,
  });

  FarmerModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];

    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['role'] = this.role;

    data['username'] = this.username;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['phone'] = this.phone;
    data['email'] = this.email;

    return data;
  }
}
