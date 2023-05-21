import 'dart:convert';

class ShowMesures {
  late int id;
  late int patient_id;
  late String measurementdate;
  late String fasting;
  late String creator;
  late String random;

  ShowMesures.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    patient_id = json["patient_id"];
    measurementdate = json["measurement_date"];
    fasting = json["Fasting"];
    creator = json["creator"];
    random = json["random"];
  }
}
