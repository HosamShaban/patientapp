import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/View/profile.dart';
import 'package:patientapp/View/profile_screen.dart';
import 'package:patientapp/View/show_mid_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Consts/colors.dart';

class EditPhoneNom extends StatefulWidget {
  EditPhoneNom({super.key});

  @override
  State<EditPhoneNom> createState() => _EditPhoneNomState();
}

class _EditPhoneNomState extends State<EditPhoneNom> {
  TextEditingController namecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  TextEditingController age = TextEditingController();

  Future<void> StoreUserData() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post("$baseUrl/api/patient/updateProfile", data: {
      "phone_No": age.text.trim(),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
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
          "تعديل  ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 300,
                    margin: EdgeInsets.all(30),
                    child: Image.asset("assets/images/edit.png")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 30),
                      child: Text(
                        "رقم الجوال",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xffEAEAEA),
                      borderRadius: BorderRadius.circular(12.0)),
                  width: 311,
                  height: 48,
                  child: TextFormField(
                    controller: age,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "0599227641",
                      hintTextDirection: TextDirection.rtl,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: ConstColors.primaryColor,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "حفظ التعديل",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              StoreUserData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'تم تحديث بياناتك',
                                    style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'فشل تحديث بياناتك',
                                    style: TextStyle(
                                      fontFamily: 'Tajawal',
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: ConstColors.primaryColor,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "استعراض",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()));
                          },
                        ),
                      ),
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
}
