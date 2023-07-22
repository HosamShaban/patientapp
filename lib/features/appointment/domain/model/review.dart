class ReviewsModel {
  int? id;
  int? patientId;
  int? doctorId;
  String? reviewDay;
  String? reviewDate;
  String? reviewTime;

  ReviewsModel({
    this.id,
    this.patientId,
    this.doctorId,
    this.reviewDay,
    this.reviewDate,
    this.reviewTime,
  });

  ReviewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    reviewDay = json['review_day'];
    reviewDate = json['review_date'];
    reviewTime = json['review_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['review_day'] = this.reviewDay;
    data['review_date'] = this.reviewDate;
    data['review_time'] = this.reviewTime;

    return data;
  }
}
