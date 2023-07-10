import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:patientapp/Model/doctors_model.dart';
import 'package:patientapp/View/booking.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/View/doctor_appoitments.dart';
import 'package:patientapp/View/reating.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/all_doctors.dart';

class doctorProfile extends StatefulWidget {
  late int id;
  doctorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<doctorProfile> createState() => _doctorProfileState();
}

class _doctorProfileState extends State<doctorProfile> {
  final String baseUrl = "https://diabete-23.000webhostapp.com";
  List<AllDoctorsModel> all_doctors = [];

  // ignore: unnecessary_cast
  int get id => widget.id as int;
  // ignore: non_constant_identifier_names

  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/doctorProfile/$id");

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
    super.initState();
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
        title: Text(
          " ملف الطبيب",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: all_doctors.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Center(child: Text("انتظر قليلا ")),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          AssetImage('assets/images/doctor(2).png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        all_doctors[0].name.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.verified,
                        size: 15,
                        color: Colors.blue,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating:
                            double.parse(all_doctors[0].rateing.toString()),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 15,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 260),
                    child: const Text(
                      "حول الطبيب",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: EdgeInsets.only(right: 20, left: 20),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                int uid = all_doctors[0].id!;
                                String name = all_doctors[0].name.toString();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DoctorAppoitments(
                                              id: uid,
                                              name: name,
                                            )));
                              },
                              child: const Text(
                                "استعراض",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const Text(
                                "ساعات العمل",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0].email.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const Text(
                                "الايميل",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0].phoneNo.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const Text(
                                "جوال",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                'غزة - الرمال الجنوبي بجوار الجامعة الاسلامية',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const Text(
                                "العنوان",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0]
                                    .DateTime
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: const Text(
                                "عضو منذ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),

                        //  Text(all_doctors[0].id.toString())
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 260),
                    child: const Text(
                      "المؤهلات",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Text(
                      all_doctors[0].qualifications.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 311,
                      height: 48,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff407BFF)),
                          onPressed: () {
                            int uid = all_doctors[0].id!;
                            String name = all_doctors[0].name!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppointmentBooking(
                                          id: uid,
                                          name: name,
                                        )));
                          },
                          child: const Text(
                            "حجز موعد",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 311,
                      height: 48,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff407BFF)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReatingDoctor()));
                          },
                          child: const Text(
                            "تقييم الطبيب ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
