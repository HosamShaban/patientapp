import 'dart:ffi';

class PaitentModel {
  final int id;
  late String name;
  late String email;
  late Long phoneNom;
  late String img;
  late String address;
  late String password;
  late int age;
  late String diabetic_type;
  late String gender;

  PaitentModel(this.id, this.name, this.email, this.address, this.gender,
      this.age, this.diabetic_type, this.password, this.phoneNom, this.img);

  PaitentModel.fromjson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        email = json['email '] ?? '',
        password = json[''] ?? '',
        phoneNom = json['phone_No'] ?? '',
        address = json['address'] ?? '',
        age = json['age'] ?? '',
        diabetic_type = json['diabetic_type'] ?? '',
        gender = json['sex'] ?? '';
}
