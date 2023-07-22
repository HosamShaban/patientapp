import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/all_doctors.dart';

class ReatingDoctor extends StatefulWidget {
  int doctor_id;

  ReatingDoctor(this.doctor_id, {super.key});

  @override
  State<ReatingDoctor> createState() => _ReatingDoctorState();
}

String baseUrl = "https://diabetes-23.000webhostapp.com";
// ignore: non_constant_identifier_names
List<AllDoctorsModel> all_doctors = [];

class _ReatingDoctorState extends State<ReatingDoctor> {
  // ignore: non_constant_identifier_names
  int get doctor_id => widget.doctor_id;

  double stars = 1;
  Future<void> RatingDoctor() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};

    try {
      var response = await dio.post(
          "$baseUrl/api/patient/ratingDoctor/$doctor_id",
          data: {"rateing": stars});
      print(response.data);
    } catch (e) {
      print('Error rating the doctor: $e');
    }
  }

  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response =
          await dio.get("$baseUrl/api/patient/doctorProfile/$doctor_id");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        var jsonData = response.data['data'];

        if (jsonData is List) {
          for (var doctorData in jsonData) {
            setState(() {
              all_doctors.add(AllDoctorsModel.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            all_doctors.add(AllDoctorsModel.fromJson(jsonData));
          });
        } else {
          // Handle other cases as needed
        }
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    FetchDoctorsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(right: 5),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          title: const Text(
            " تقييم الطبيب",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            const SizedBox(height: 30),
            const Text(
              'تقييم تجربتك مع الطبيب ',
              style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  color: Color(0xff121111),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              all_doctors[0].name.toString(),
              style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                  color: Color(0xff121111),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            const Text(
              'عزيزي المريض التزم الشفافية والمصداقية عند تقييم الطبيب وتذكر ان هذا يساعدنا بتطوير التطبيق اكثر',
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff414141),
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: CircleAvatar(
                radius: 45.0,
                backgroundImage: AssetImage('assets/images/doctor(2).png'),
              ),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  stars = rating;
                  print(stars.toInt());
                });
              },
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: const Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(12.0)),
              width: 327,
              height: 108,
              child: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "اوصف تجربتك بشكل عام (اختياري)",
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: const Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(12.0)),
              width: 327,
              height: 108,
              child: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "أكثر 3 أشياء لم تعجبك بالطبيب (اختياري)",
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: const Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(12.0)),
              width: 327,
              height: 108,
              child: TextFormField(
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: "أكثر 3 أشياء أعجبتك بالطبيب (اختياري)",
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 311,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff407BFF)),
                    onPressed: () {
                      RatingDoctor();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'تم اضافة تقييمك بنجاح',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      );
                    },
                    child: const Text(
                      "تقييم ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
