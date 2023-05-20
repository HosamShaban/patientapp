class Mesures {
  late int Fasting;
  late int creator;
  late int random;

  Mesures(this.Fasting, this.creator, this.random);

  Mesures.fromjson(Map<String, dynamic> map) {
    this.Fasting = map['Fasting'];
    this.creator = map['creator'];
    this.random = map['random'];
  }
}
