import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SugarMeasurement extends StatefulWidget {
  const SugarMeasurement({Key? key}) : super(key: key);

  @override
  State<SugarMeasurement> createState() => _SugarMeasurementState();
}

class _SugarMeasurementState extends State<SugarMeasurement> {
  TextEditingController Fastingcontroller = TextEditingController();
  TextEditingController creatorcontroller = TextEditingController();
  TextEditingController randomcontroller = TextEditingController();
  final String baseUrl = "https://diabetes-23.000webhostapp.com";

  Future<void> StoreMesurments() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response =
        await dio.post("$baseUrl/api/patient/storeMeasurement", data: {
      "Fasting": Fastingcontroller.text.trim(),
      "creator": creatorcontroller.text.trim(),
      "random": randomcontroller.text.trim(),
    });
    print(response.data);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        title: const Text(
          "قياس السكر",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  width: 311,
                  height: 220,
                  child: Image.asset("assets/images/photo4.jpeg"),
                ),
                SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: 327,
                  height: 185,
                  decoration: BoxDecoration(
                      color: const Color(0xffEAEAEA),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: [
                      const Text(
                        "ادخل القياسات كاملة وبدون فواصل عشرية",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(20.0)),
                            width: 172,
                            height: 32,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                } else if (value.contains(".") ||
                                    value.contains(',')) {
                                  return 'قيمة غير صحيحة';
                                } else
                                  return null;
                              },
                              controller: Fastingcontroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                suffix: Text(
                                  "mg / di ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                hintTextDirection: TextDirection.rtl,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text("صائم"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(20.0)),
                            width: 172,
                            height: 32,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                } else if (value.contains(".") ||
                                    value.contains(',')) {
                                  return 'قيمة غير صحيحة';
                                } else
                                  return null;
                              },
                              controller: creatorcontroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                suffix: Text(
                                  "mg / di ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                hintTextDirection: TextDirection.rtl,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text("فاطر"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(20.0)),
                            width: 172,
                            height: 32,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'هذا الحقل مطلوب';
                                } else if (value.contains(".") ||
                                    value.contains(',')) {
                                  return 'قيمة غير صحيحة';
                                } else
                                  return null;
                              },
                              controller: randomcontroller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                suffix: Text(
                                  "mg / di ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                hintTextDirection: TextDirection.rtl,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Text("عشوائي"),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 327,
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff407BFF)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          StoreMesurments();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'تم حفظ القراءة بنجاح',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'فشل حفظ القراءة',
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
                      child: const Text(
                        "تسجيل",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
