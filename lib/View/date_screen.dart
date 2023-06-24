import 'package:dio/dio.dart';
import 'package:patientapp/Consts/colors.dart';
import 'package:patientapp/controller/date_controller.dart';
import 'package:patientapp/widget/date_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/all_doctors.dart';
import '../Model/appointments.dart';
import '../controller/dio_helper.dart';
import '../controller/doctors_controller.dart';

class DateScreen extends StatefulWidget {
  const DateScreen({Key? key}) : super(key: key);

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  final doctorController = DoctorsController();
  String query = '';
  String selectedFilter = 'All';
  String baseUrl = "https://diabetes-2023.000webhostapp.com";
  List<AppointmentsModel> all_doctors = [];
  @override
  void initState() {
    FetchAppointmentsFromApi();
    //fetchDataWithToken();
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
              all_doctors.add(AppointmentsModel.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            all_doctors.add(AppointmentsModel.fromJson(jsonData));
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
            "مواعيدي",
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
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: all_doctors.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    height: 100,
                    margin: EdgeInsets.all(15),
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
                    child: ListTile(
                      trailing: CircleAvatar(
                          foregroundImage:
                              AssetImage("assets/images/person.jpg")),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status: " + all_doctors[index].status.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                all_doctors[index].bookingDay.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                all_doctors[index].bookingDate.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                all_doctors[index].bookingTime.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
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
