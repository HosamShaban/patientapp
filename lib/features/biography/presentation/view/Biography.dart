import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/resources/colors.dart';

class Biography extends StatefulWidget {
  @override
  State<Biography> createState() => _BiographyState();
}

class _BiographyState extends State<Biography> {
  Map<String, dynamic> bio = {};
  final String baseUrl = "https://diabetes-23.000webhostapp.com";

  void FetchPatintDataFromApi() async {
    final Dio dio = Dio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/profile");
      if (response.statusCode == 200) {
        setState(() {
          bio = response.data;
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
    bio.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: bio.isEmpty
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
                itemCount: bio['data']['patient_biography'].length,
                itemBuilder: (context, index) {
                  final Bio = bio['data']['patient_biography'][index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ConstColors.primaryColor,
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 190),
                                child: const Text(
                                  " : التشخيص",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            ' ${Bio['diagnostics']}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: const Text(
                                  ": العلاج",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            ' ${Bio['medications']}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ' ${Bio['created_at']}'.substring(0, 11),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              const Text(
                                " / تاريخ التشخيص",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ' ${Bio['created_at']}'.substring(12, 17),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.timer,
                                color: Colors.white,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
