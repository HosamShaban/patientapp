import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:patientapp/Model/all_doctors.dart';
import 'package:patientapp/Model/doctors_model.dart';
import 'package:patientapp/View/doctorprofile.dart';
import 'package:patientapp/View/filter_view.dart';
import 'package:patientapp/View/saerch_result.dart';
import 'package:patientapp/controller/doctors_controller.dart';
import 'package:patientapp/widget/doctors_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/dio_helper.dart';

class DoctorScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const DoctorScreen({super.key, this.scaffoldKey});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final doctorController = DoctorsController();
  String query = '';
  String selectedFilter = 'All';
  final String baseUrl = "https://diabete-23.000webhostapp.com";
  //TextEditingController search = TextEditingController();
  late String search;
  List<AllDoctorsModel> all_doctors = [];
  @override
  void initState() {
    FetchDoctorsFromApi();
    //fetchDataWithToken();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    all_doctors.clear();
    super.dispose();
  }

  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/doctors");

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
            " الاطباء",
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
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (search.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'من فضلك أدخل الاسم',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResult(
                                          data: search,
                                        )),
                              );
                            },
                            child: const Icon(Icons.search)),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                search = value;
                                // Search();
                              },
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                hintText: "  بحث ",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: all_doctors.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              int id = all_doctors[index].id!;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          doctorProfile(id: id)));
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 70,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Dr Name : " +
                                            all_doctors[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'غزة - الرمال الجنوبي ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }

  void getMesurse() {
    DioHelper.getData("doctors").then((value) {
      var random = value.data;
      print(random);
      print(value.headers);
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  void fetchDataWithToken() async {
    Dio dio = Dio(); // Create a Dio instance

    String baseUrl = "https://diabetes-2023.000webhostapp.com";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token'); // Set the Authorization header
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(
          "$baseUrl/api/patient/doctors"); // Replace with your API endpoint

      if (response.statusCode == 200) {
        // Data fetched successfully
        var data = response.data;
        print(response.data);
        // Process the data as needed
      } else {
        // Handle error
        print("Request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle Dio errors
      print("Error: $e");
    }
  }
}
