import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReatingDoctor extends StatefulWidget {
  const ReatingDoctor({super.key});

  @override
  State<ReatingDoctor> createState() => _ReatingDoctorState();
}

String baseUrl = "https://diabete-23.000webhostapp.com";

class _ReatingDoctorState extends State<ReatingDoctor> {
  double stars = 1;
  Future<void> RatingDoctor() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post("$baseUrl/api/patient/ratingDoctor/4", data: {
      "rateing": stars,
    });
    print(response.data);
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
            "تقييم الطبيب",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(children: [
              SizedBox(height: 30),
              Text(
                'تقييم تجربتك مع الطبيب حسام شعبان',
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20,
                    color: Color(0xff121111),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              const Text(
                'عزيزي المريض التزم الشفافية والمصداقية عند تقييم الطبيب وتذكر ان هذا يساعدنا بتطوير التطبيق اكثر',
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff414141),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage('assets/images/doctor(1).png'),
                ),
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    stars = rating;
                    print(stars.toInt());
                  });
                },
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(12.0)),
                width: 327,
                height: 108,
                child: TextFormField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "اوصف تجربتك بشكل عام (اختياري)",
                    hintTextDirection: TextDirection.rtl,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(12.0)),
                width: 327,
                height: 108,
                child: TextFormField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "أكثر 3 أشياء لم تعجبك بالطبيب (اختياري)",
                    hintTextDirection: TextDirection.rtl,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: const Color(0xffEAEAEA),
                    borderRadius: BorderRadius.circular(12.0)),
                width: 327,
                height: 108,
                child: TextFormField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: "أكثر 3 أشياء أعجبتك بالطبيب (اختياري)",
                    hintTextDirection: TextDirection.rtl,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 311,
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff407BFF)),
                      onPressed: () {
                        RatingDoctor();
                      },
                      child: const Text(
                        "تقييم ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                ),
              ),
              SizedBox(height: 20),
            ]),
          ),
        ));
  }
}
