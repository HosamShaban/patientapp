// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/all_doctors.dart';
import 'booking.dart';
import 'doctor_appoitments.dart';

class DoctorAppoitments extends StatefulWidget {
  int id;
  String name;
  DoctorAppoitments({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<DoctorAppoitments> createState() => _DoctorAppoitmentsState();
}

class _DoctorAppoitmentsState extends State<DoctorAppoitments> {
  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  // ignore: non_constant_identifier_names
  Map<String, dynamic> all_doctors = {};

  // ignore: unnecessary_cast
  int get id => widget.id as int;
  String get name => widget.name;

  // ignore: non_constant_identifier_names

  void FetchDoctorAppoitmentsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/doctorProfile/$id");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          all_doctors = response.data;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    FetchDoctorAppoitmentsFromApi();
    super.initState();
  }

  @override
  void dispose() {
    all_doctors.clear();
    super.dispose();
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
            "مواعيد عمل الطبيب",
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
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: all_doctors['data']['work_hours'].length,
                itemBuilder: (context, index) {
                  final workHour = all_doctors['data']['work_hours'][index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff407BFF)),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Day: ${workHour['day']}',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      subtitle: Text(
                        'From  ${workHour['start_time'].toString().substring(0, 5)}  To   ${workHour['end_time'].toString().substring(0, 5)}',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              ));
  }
}
