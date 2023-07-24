class Mesures {
  int? Fasting;
  int? Creator;
  int? Random;
  String? DateTime;

  Mesures(this.Fasting, this.Creator, this.Random, this.DateTime);

  Mesures.fromJson(Map<String, dynamic> json) {
    Fasting = json['Fasting'];
    Creator = json['creator'];
    Random = json['random'];
    DateTime = json['created_at'];
  }
}
