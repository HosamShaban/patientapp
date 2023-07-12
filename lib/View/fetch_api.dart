import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/all_doctors.dart';

class ShowMesures extends StatefulWidget {
  const ShowMesures({super.key});

  @override
  State<ShowMesures> createState() => _ShowMesuresState();
}

class _ShowMesuresState extends State<ShowMesures> {
  final String baseUrl = "https://diabetes-2023.000webhostapp.com";
  List<AllDoctorsModel> all_doctors = [];

  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var response = await dio.get("$baseUrl/api/patient/doctors");
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        for (var doctor in response.data) {
          setState(() {
            all_doctors.add(AllDoctorsModel.fromJson(doctor));
          });
        }
        print(response.data);
      } else {
        print('Error : ${response.data}');
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // FetchDoctorsFromApi();
    //test();
    getDoctors();
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
            " Fetch api screen ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: all_doctors.isEmpty
            ? const Center(child: Text("Loading..."))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: all_doctors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Row(
                      children: [
                        CircleAvatar(backgroundImage: AssetImage("")),
                        SizedBox(width: 5),
                        Text(all_doctors[index].name.toString())
                      ],
                    ),
                    trailing: Text(all_doctors[index].rateing.toString()),
                    title: Text(all_doctors[index].qualifications.toString()),
                    subtitle: Row(
                      children: [
                        Icon(Icons.home),
                        Text(all_doctors[index].address.toString()),
                        Icon(Icons.phone),
                        Text(all_doctors[index].phoneNo.toString()),
                      ],
                    ),
                  );
                }));
  }

  Future<void> getDataFromApi() async {
    try {
      // Define the API endpoint
      String url = '$baseUrl/api/patient/showMeasurements';

      // Make the GET request
      final Dio dio = Dio();
      dio.options.headers = {
        'Authorization': 'Bearer 19|CQgrjm8Ow0FUoJS3dHUyuy1Xl1HVvIhU4UiTmGgw',
      };
      Response response = await dio.get(url);

      // Handle the response
      if (response.statusCode == 200) {
        print('Data received successfully');
        print(response.data);
      } else {
        print('Error retrieving data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print('token is : $token');
  }

  Future getDoctors() async {
    Dio dio = Dio(); // Create a Dio instance

    String baseUrl = "https://diabetes-23.000webhostapp.com";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token'); // Set the Authorization header
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(
          "$baseUrl/api/patient/doctors"); // Replace with your API endpoint

      if (response.statusCode == 200) {
        // Data fetched successfully
        for (var doctor in response.data) {
          setState(() {
            all_doctors.add(AllDoctorsModel.fromJson(doctor));
          });
          print(response.data);
        }
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
