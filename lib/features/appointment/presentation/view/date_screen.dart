import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/features/doctors/presentation/controller/doctors_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/dio_helper.dart';
import '../../domain/model/appointments.dart';
import 'appintment_details.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({Key? key}) : super(key: key);

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  final doctorController = DoctorsController();
  String query = '';
  String selectedFilter = 'All';
  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  List<AppointmentsModel> appoitments = [];
  @override
  void initState() {
    FetchAppointmentsFromApi();
    super.initState();
  }

  void FetchAppointmentsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/showAppointments");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        var jsonData = response.data['data'];

        if (jsonData is List) {
          for (var doctorData in jsonData) {
            setState(() {
              appoitments.add(AppointmentsModel.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            appoitments.add(AppointmentsModel.fromJson(jsonData));
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
  void dispose() {
    appoitments.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: appoitments.isEmpty
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
                scrollDirection: Axis.vertical,
                itemCount: appoitments.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    height: 60,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentDetails(
                                      id: appoitments[index].id,
                                      doctor_id: appoitments[index].doctorId,
                                      day: appoitments[index]
                                          .bookingDay
                                          .toString(),
                                      date: appoitments[index]
                                          .bookingDate
                                          .toString(),
                                      time: appoitments[index]
                                          .bookingTime
                                          .toString(),
                                      status:
                                          appoitments[index].status.toString(),
                                    )));
                      },
                      child: ListTile(
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Status  : ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              appoitments[index].status.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: appoitments[index]
                                          .status
                                          .toString()
                                          .startsWith("conf")
                                      ? Colors.green
                                      : appoitments[index]
                                              .status
                                              .toString()
                                              .startsWith("can")
                                          ? Colors.red
                                          : Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
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
    Dio dio = Dio();

    String baseUrl = "https://diabetes-2023.000webhostapp.com";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get("$baseUrl/api/patient/doctors");

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print("Request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
