import 'dart:ffi';

class PaitentModel {
  String name;
  String email;
  String gender;
  String phoneNom;
  String age;
  PaitentModel(
      {required this.name,
      required this.email,
      required this.gender,
      required this.age,
      required this.phoneNom});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["phone_No"] = phoneNom;
    data['email'] = email;
    data['sex'] = gender;
    data['age'] = age;
    return data;
  }
}
