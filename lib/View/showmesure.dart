import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowAllMesures extends StatefulWidget {
  const ShowAllMesures({super.key});

  @override
  State<ShowAllMesures> createState() => _ShowAllMesuresState();
}

class _ShowAllMesuresState extends State<ShowAllMesures> {
  final String baseUrl = "https://diabetes-2023.000webhostapp.com";
  void getdata() async {
    try {
      var response = await Dio().get("$baseUrl/api/patient/showMeasurements");
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'استعراض القياسات',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: IconButton(
              onPressed: () {
                //       Navigator.push(context,MaterialPageRoute(builder: (context) => const ()));
              },
              icon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              )),
        ),
      ),
      body: Center(
          child: TextButton(
        child: Text("Show Mesures"),
        onPressed: getdata,
      )),
    );
  }
}
