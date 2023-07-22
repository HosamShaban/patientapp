import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/Defaultimages.dart';
import 'package:patientapp/core/resources/colors.dart';
import 'package:patientapp/features/medical_data/presentation/controller/show_mid_data.dart';
import 'package:patientapp/features/profile/presentation/view/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditType extends StatefulWidget {
  EditType({super.key});

  @override
  State<EditType> createState() => _EditTypeState();
}

class _EditTypeState extends State<EditType> {
  TextEditingController namecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  String Diabetictype = "Type 1 Diabetes";

  Future<void> StoreUserData() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post("$baseUrl/api/patient/updateProfile", data: {
      "diabetic_type": Diabetictype,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
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
                    margin: const EdgeInsets.all(30),
                    child: Image.asset(DefaultImages.edit)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: const Text(
                        "نوع السكري",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("النوع الثاني",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Radio(
                        activeColor: Colors.black,
                        value: "Type 2 Diabetes",
                        groupValue: Diabetictype,
                        onChanged: (value) {
                          setState(() {
                            Diabetictype = value.toString();
                          });
                        },
                      ),
                      const Text("النوع الأول",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Radio(
                        activeColor: Colors.black,
                        value: "Type 1 Diabetes",
                        groupValue: Diabetictype,
                        onChanged: (value) {
                          setState(() {
                            Diabetictype = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("لا أعرف",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Radio(
                        activeColor: Colors.black,
                        value: "unknown",
                        groupValue: Diabetictype,
                        onChanged: (value) {
                          setState(() {
                            Diabetictype = value.toString();
                          });
                        },
                      ),
                      const Text("سكري الحمل",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Radio(
                        activeColor: Colors.black,
                        value: "Gestational diabetes",
                        groupValue: Diabetictype,
                        onChanged: (value) {
                          setState(() {
                            Diabetictype = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(top: 15.0),
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
                          },
                        ),
                      ),
                    ],
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
                                    builder: (context) =>
                                        const ShowMedicalData()));
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
