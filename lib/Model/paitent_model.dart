 
class PaitentModel {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phoneNo;
  int? age;
  String? image;
  String? address;
  String? birthdate;
  String? gender;
  String? diabeticType;
  String? patientStatus;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? patientBiography;

  PaitentModel({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNo,
    this.age,
    this.image,
    this.address,
    this.birthdate,
    this.gender,
    this.diabeticType,
    this.patientStatus,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.patientBiography,
  });

  PaitentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_No'];
    age = json['age'];
    image = json['image'];
    address = json['address'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    diabeticType = json['diabetic_type'];
    patientStatus = json['patient_status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    patientBiography = json['patient_biography'];
  }
}
