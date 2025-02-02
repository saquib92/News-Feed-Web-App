class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? password;

  UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.phoneNo,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }
}
