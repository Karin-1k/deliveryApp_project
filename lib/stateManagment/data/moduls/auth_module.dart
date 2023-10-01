import 'dart:convert' as co;

class AuthModule {
  String name;
  String phone;
  String email;
  String password;
  AuthModule({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    };
    return json;
  }

  String get toJson => co.json.encode(toMap());
}
