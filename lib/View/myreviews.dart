import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/View/reviews_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  // ignore: non_constant_identifier_names
  Map<String, dynamic> reviews = {};
  bool showWidget = false;
  void startTimer() {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        showWidget = true;
      });
    });
  }
  // ignore: unnecessary_cast
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  void FetchMesuresFromApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/profile");

      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          reviews = response.data;
        });
      }
    } on DioError catch (e) {
      print('Error retrieving doctor information: $e');
    }
  }

  @override
  void initState() {
    FetchMesuresFromApi();
    startTimer();
    //fetchDataWithToken();
    super.initState();
  }

  @override
  void dispose() {
    reviews.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: reviews.isEmpty
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
                itemCount: reviews['data']['reviews'].length,
                itemBuilder: (context, index) {
                  final Reviews = reviews['data']['reviews'][index];
                  return Container(
                    padding: EdgeInsets.all(5),
                    height: 60,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green,
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
                                builder: (context) => ReviewsDetails(
                                      doctor_id: Reviews['doctor_id'],
                                      day: '${Reviews['review_day']}',
                                      date: '${Reviews['review_date']}',
                                      time: '${Reviews['review_time']}',
                                    )));
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Day : ${Reviews['review_day']}',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
