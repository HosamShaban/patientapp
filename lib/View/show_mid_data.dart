import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Model/medical_patient_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Consts/colors.dart';
import 'Medicaldata.dart';

class ShowMedicalData extends StatefulWidget {
  const ShowMedicalData({super.key});

  @override
  State<ShowMedicalData> createState() => _ShowMedicalDataState();
}

class _ShowMedicalDataState extends State<ShowMedicalData> {
  Map<String, dynamic> responseData = {};
  String baseUrl = "https://diabetes-2023.000webhostapp.com";

  void FetchPatintDataFromApi() async {
    final Dio dio = Dio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/profile");
      if (response.statusCode == 200) {
        // Access the 'data' object
        setState(() {
          responseData = response.data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    FetchPatintDataFromApi();
  }

  @override
  void dispose() {
    responseData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "بياناتك الطبية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: responseData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blueAccent,
            ))
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 220,
                      child: Image.asset("assets/images/pro.png"),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: const Text(
                        "الاسم",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text(' ${responseData['data']['name'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: const Text(
                        "الجنس",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text(
                            ' ${responseData['data']['gender'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 240),
                      child: const Text(
                        "نوع السكر",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text(
                            ' ${responseData['data']['diabetic_type'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: const Text(
                        "العمر",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text('  ${responseData['data']['age'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: const Text(
                        "العنوان",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text(
                            ' ${responseData['data']['address'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: const Text(
                        "العمر",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 48,
                      child: Center(
                        child: Text(' ${responseData['data']['age'] ?? 'N/D'}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: ConstColors.primaryColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medicaldata()));
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 80),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      'تعديل',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
