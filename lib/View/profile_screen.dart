import 'package:dio/dio.dart';
import 'package:patientapp/View/Medicaldata.dart';
import 'package:patientapp/View/Personaldata.dart';
import 'package:patientapp/View/profile.dart';
import 'package:patientapp/View/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Consts/colors.dart';
import '../Model/paitent_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  String FullName = "اسم المريض";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50.0, bottom: 40.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "صفحتك الشخصية",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ProfilePic(),
                ),
                const SizedBox(height: 5),
                const Text(
                  " الصورة الشخصية ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: ConstColors.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              SizedBox(width: 80),
                              Expanded(
                                  child: Text(
                                ' البيانات الشخصية',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: ConstColors.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Medicaldata()));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              SizedBox(width: 80),
                              Expanded(
                                  child: Text(
                                'البيانات الطبية',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                            ],
                          ),
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
    );
  }
}
