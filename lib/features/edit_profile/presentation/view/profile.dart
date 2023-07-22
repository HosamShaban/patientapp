import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/Defaultimages.dart';
import 'package:patientapp/features/edit_profile/presentation/controller/edit_address.dart';
import 'package:patientapp/features/edit_profile/presentation/controller/edit_email.dart';
import 'package:patientapp/features/profile/presentation/view/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/edit_ageB.dart';
import '../controller/edit_nameB.dart';
import '../controller/edit_phone.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> responseData = {};
  final String baseUrl = "https://diabetes-23.000webhostapp.com";

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
      print(response.data);
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
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
          "بياناتك الشخصية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: responseData.isEmpty
          ? Center(
              child: Container(
                width: 150,
                height: 150,
                child: const CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      width: 311,
                      height: 220,
                      child: Image.asset(DefaultImages.profileData),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "الاسم",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditNameB()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAEAEA),
                              borderRadius: BorderRadius.circular(12.0)),
                          width: 260,
                          height: 48,
                          child: Center(
                            child: Text(
                                '${responseData['data']['name'] ?? 'N/D'}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "الايميل",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditEmail()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAEAEA),
                              borderRadius: BorderRadius.circular(12.0)),
                          width: 260,
                          height: 48,
                          child: Center(
                            child: Text(
                                ' ${responseData['data']['email'] ?? 'N/D'}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "رقم الجوال",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPhoneNom()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAEAEA),
                              borderRadius: BorderRadius.circular(12.0)),
                          width: 260,
                          height: 48,
                          child: Center(
                            child: Text(
                                ' ${responseData['data']['phone_No'] ?? 'N/D'}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "العمر",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAgeB()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAEAEA),
                              borderRadius: BorderRadius.circular(12.0)),
                          width: 260,
                          height: 48,
                          child: Center(
                            child: Text(
                                ' ${responseData['data']['age'] ?? 'N/D'}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: const Text(
                            "العنوان",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAdress()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAEAEA),
                              borderRadius: BorderRadius.circular(12.0)),
                          width: 260,
                          child: Center(
                            child: Text(
                                ' ${responseData['data']['address'] ?? 'N/D'}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
