import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/all_doctors.dart';
import 'doctor_appoitments.dart';

class ReviewsDetails extends StatefulWidget {
  String date;
  String time;
  // ignore: non_constant_identifier_names
  int doctor_id;
  String day;

  ReviewsDetails({
    super.key,
    // ignore: non_constant_identifier_names
    required this.doctor_id,
    required this.date,
    required this.time,
    required this.day,
  });

  @override
  State<ReviewsDetails> createState() => _ReviewsDetailsState();
}

class _ReviewsDetailsState extends State<ReviewsDetails> {
  // ignore: non_constant_identifier_names
  int get doctor_id => widget.doctor_id;
  String get time => widget.time;
  String get date => widget.date;
  String get day => widget.day;

  final String baseUrl = "https://diabete-23.000webhostapp.com";
  List<AllDoctorsModel> all_doctors = [];
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
          "تفاصيل المراجعة",
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
                  const SizedBox(height: 20),
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Image.asset("assets/images/red.png"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: const Text(
                          "تفاصيل المراجعة",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0].name.toString(),
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
                                "اسم الطبيب",
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
                                all_doctors[0].address.toString(),
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
                                "العنوان",
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
                            SizedBox(width: 10),
                            Text(
                              day,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                "يوم المراجعة",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                "تاريخ المراجعة",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              time.substring(0, 5),
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                "الوقت",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        //  Text(all_doctors[0].id.toString())
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 350,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: const Color(0xffD9D9D9),
                            ),
                            onPressed: () {
                              String nom = all_doctors[0].phoneNo.toString();
                              final Uri whatsapp =
                                  Uri.parse('https://wa.me/$nom');
                              launchUrl(whatsapp);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                    image:
                                        AssetImage("assets/images/whats.png")),
                                SizedBox(width: 10),
                                Text(
                                  'تحدث مع الطبيب',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
