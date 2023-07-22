import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/Defaultimages.dart';
import 'package:patientapp/features/doctors/domain/model/all_doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final String baseUrl = "https://diabetes-23.000webhostapp.com";
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
        title: const Text(
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
                            child: const CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        const Center(child: Text("انتظر قليلا ")),
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
                  Container(
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffD9D9D9),
                    ),
                    child: Image.asset(DefaultImages.review),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 220),
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
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0].name.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
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
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                all_doctors[0].phoneNo.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
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
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
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
                            const SizedBox(width: 10),
                            Text(
                              day,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
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
                            const SizedBox(width: 10),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
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
                            const SizedBox(width: 10),
                            Text(
                              time,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
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
                    width: 310,
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
                              String nom = '+972569747558';
                              String whatsApp =
                                  "whatsapp://send?phone=$nom&text=${Uri.encodeFull('مرحبا دكتور')}";
                              launchUrl(Uri.parse(whatsApp));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(image: AssetImage(DefaultImages.whats)),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
