import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:patientapp/controller/home_controller.dart';
import 'package:patientapp/onboarding.dart';
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
  List<Mesures> mesures = [];

  List imageList = [
    {"id": 1, "image_path": 'assets/images/banner.png'},
    {"id": 2, "image_path": 'assets/images/bestsellersbanner.png'},
    {"id": 3, "image_path": 'assets/images/banner.png'}
  ];
  bool showWidget = false;
  void startTimer() {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        showWidget = true;
      });
    });
  }

  String? token;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  final String baseUrl = "https://diabete-23.000webhostapp.com";
  void showMeasurements() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/showMeasurements");

      print(response.statusCode);
      //(response.data);
      print(MediaQuery.of(context).size.width.toString());
      print(MediaQuery.of(context).size.height.toString());

      if (response.statusCode == 200) {
        var jsonData = response.data['data'];

        if (jsonData is List) {
          for (var doctorData in jsonData) {
            setState(() {
              mesures.add(Mesures.fromJson(doctorData));
            });
          }
        } else if (jsonData is Map<String, dynamic>) {
          setState(() {
            mesures.add(Mesures.fromJson(jsonData));
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
    showMeasurements();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mesures.clear();
    super.dispose();
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
                AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.question,
                    body: const Center(
                      child: Text(
                        'هل تريد تأكيد تسجيل الخروج من التطبيق ؟',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    btnOkOnPress: () {
                      Logout();
                    },
                    btnOk: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Logout();
                        },
                        child: const Text(
                          "نعم",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))).show();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/pho1 (2).png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 200,
                              width: 360,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/pho2 (2).png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 200,
                              width: 360,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/pho3 (2).png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xff407BFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                                child: Text(
                              "سجل القياسات",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                        height: 400,
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: mesures.isEmpty
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
                                                        color:
                                                            Colors.blueAccent,
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
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: mesures.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Color.fromARGB(
                                                  255, 138, 138, 141),
                                            ),
                                            child: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "Fating : ${mesures[index].Fasting}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    " Creator : ${mesures[index].Creator}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    " Random : ${mesures[index].Random}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${mesures[index].DateTime}'
                                                        .substring(11, 16),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "في",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    '${mesures[index].DateTime}'
                                                        .substring(0, 10),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    " تاريخ الادخال",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
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

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OnBoarding()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'تم تسجيل خروجك',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        print('Error : ${response.data}');
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
