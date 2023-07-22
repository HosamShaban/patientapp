import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/features/booking/presentation/view/doctorprofile.dart';
import 'package:patientapp/features/doctors/domain/model/all_doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResult extends StatefulWidget {
  late String data;

  SearchResult({required this.data, super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

String baseUrl = "https://diabetes-23.000webhostapp.com";
List<AllDoctorsModel> search_doctors = [];

class _SearchResultState extends State<SearchResult> {
  String get search => widget.data;
  bool showWidget = false;
  void startTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showWidget = true;
      });
    });
  }

  @override
  void initState() {
    Search();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    search_doctors.clear();
    super.dispose();
  }

  Future Search() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response =
          await dio.get("$baseUrl/api/patient/searchDoctors?query=$search");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        var jsonData = response.data['data'];

        if (jsonData is List) {
          for (var doctorData in jsonData) {
            setState(() {
              search_doctors.add(AllDoctorsModel.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            search_doctors.add(AllDoctorsModel.fromJson(jsonData));
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
            "الاطباء",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: search_doctors.isEmpty
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
                              width: 170,
                              height: 170,
                              child: const CircularProgressIndicator(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Center(
                            child: showWidget
                                ? const Text(
                                    'نأسف .. الطبيب غير مسجل',
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Center(
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: search_doctors.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              int id = search_doctors[index].id!;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          doctorProfile(id: id)));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 70,
                              margin: const EdgeInsets.all(15),
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
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        search_doctors[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Khan younes",
                                          style: TextStyle(
                                            fontSize: 17,
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
}
