import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/mesure.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = HomeController();
  String query = '';
  List<Mesures> all_doctors = [];

  List imageList = [
    {"id": 1, "image_path": 'assets/images/banner.png'},
    {"id": 2, "image_path": 'assets/images/bestsellersbanner.png'},
    {"id": 3, "image_path": 'assets/images/banner.png'}
  ];
  bool showWidget = false;
  void startTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showWidget = true;
      });
    });
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  String baseUrl = "https://diabetes-2023.000webhostapp.com";
  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/showMeasurements");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        var jsonData = response.data['data'];

        if (jsonData is List) {
          for (var doctorData in jsonData) {
            setState(() {
              all_doctors.add(Mesures.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            all_doctors.add(Mesures.fromJson(jsonData));
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
  void initState() {
    FetchDoctorsFromApi();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'الصفحة الرئيسية',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: IconButton(
              onPressed: () {
                Logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5),
                          Container(
                            height: 200,
                            width: 360,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/pho1 (2).png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 200,
                            width: 360,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/pho2 (2).png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 200,
                            width: 360,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/pho3 (2).png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 350,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 300,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xff407BFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                  child: Text(
                                "القراءات السابقة",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: all_doctors.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 200.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: Container(
                                                    width: 155,
                                                    height: 155,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: showWidget
                                                      ? const Text(
                                                          'ليس لديك اي قراءات ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
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
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: all_doctors.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            height: 70,
                                            margin: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: ListTile(
                                              trailing: const Expanded(
                                                child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor:
                                                        Color(0xff407BFF),
                                                    foregroundImage: AssetImage(
                                                        "assets/images/measure.png")),
                                              ),
                                              title: Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      all_doctors[index]
                                                          .DateTime
                                                          .toString()
                                                          .substring(0, 19),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Icon(
                                                      Icons.timer,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              subtitle: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "فاطر :" +
                                                            all_doctors[index]
                                                                .Creator
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "صائم :" +
                                                            all_doctors[index]
                                                                .Fasting
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        "عشوائي: " +
                                                            all_doctors[index]
                                                                .Random
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future Logout() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers = {'Authorization': 'Bearer $token'};

      var response = await dio.get("$baseUrl/api/logout");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Error : ${response.data}');
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
