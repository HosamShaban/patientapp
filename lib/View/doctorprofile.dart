import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:patientapp/Model/doctors_model.dart';
import 'package:patientapp/View/booking.dart';
import 'package:flutter/material.dart';
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
  String baseUrl = "https://diabetes-2023.000webhostapp.com";
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
    //fetchDataWithToken();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          AssetImage('assets/images/doctor(1).png'),
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
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
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
                    width: 327,
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /* Container(
                        margin: const EdgeInsets.only(left: 5.5),
                        width: 91,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            "مفتوح الأن",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),*/
                            Container(
                              margin: const EdgeInsets.only(left: 200, top: 3),
                              child: const Text(
                                "ساعات العمل",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text(
                            " من الساعة الثامنة صباحا حتى الساعة الثانية ظهرا",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(left: 190),
                          child: const Text(
                            "البريد الإلكتروني",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 150),
                          child: Text(
                            all_doctors[0].email.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.only(left: 210),
                          child: const Text(
                            "رقم الجوال",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 210),
                          child: Text(
                            all_doctors[0].phoneNo.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 220),
                          child: const Text(
                            "عضو منذ ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 210),
                          child: Text(
                            all_doctors[0].DateTime.toString().substring(0, 10),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
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
                    padding: const EdgeInsets.only(top: 10),
                    width: 327,
                    height: 95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Text(''),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 311,
                      height: 48,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff407BFF)),
                          onPressed: () {},
                          child: const Text(
                            "تحدث مع الطبيب",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 311,
                      height: 48,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff407BFF)),
                          onPressed: () {
                            int uid = all_doctors[0].id!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentBooking(id: uid)));
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
