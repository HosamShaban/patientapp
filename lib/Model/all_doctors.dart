import 'dart:ffi';

class AllDoctorsModel {
  final int id;
  late String name;
  late String qualifications;
  late Long phoneNom;
  late String img;
  late String address;
  late int rating;

  AllDoctorsModel(this.id, this.name, this.qualifications, this.address,
      this.rating, this.phoneNom, this.img);

  AllDoctorsModel.fromjson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        qualifications = json['qualifications'] ?? '',
        phoneNom = json['phone_No'] ?? '',
        address = json['address'] ?? '',
        rating = json['rateing'] ?? '';
}
