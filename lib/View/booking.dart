// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBooking extends StatefulWidget {
  int id;
  String name;
  AppointmentBooking({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController = selectedDate as TextEditingController;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  final String baseUrl = "https://diabete-23.000webhostapp.com";
  TextEditingController nameController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController TimeController = TextEditingController();

  int get id => widget.id;
  String get name => widget.name;

  Future<void> appointmentBooking() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    var response =
        await dio.post("$baseUrl/api/patient/appointmentBooking/$id", data: {
      "name": nameController.text.trim(),
      "booking_day": dayController.text.trim(),
      "booking_date": emailController.text.trim(),
      "booking_time": TimeController.text.trim()
    });
    print(response.data);
  }

  TimeOfDay time = const TimeOfDay(hour: 7, minute: 15);
  void selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        hourLabelText: "22",
        minuteLabelText: "20");
    if (newTime != null) {
      setState(() {
        time = newTime;
      });
    }
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
        title: Text(
          " حجز موعد مع الطبيب",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "ستصلك رسالة بمجرد قبول أو رفض الحجز",
                        style: TextStyle(
                            color: const Color(0xff407BFF),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 15),
                      const Text(
                        "اسم الطبيب",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
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
                          enabled: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: name.toString(),
                            hintStyle: TextStyle(color: Colors.black),
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "اسم المريض",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (value.length <= 2) {
                              return ("من فضلك أدخل الاسم بشكل صحيح");
                            } else
                              return null;
                          },
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "الاسم كامل",
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "يوم الحجز",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (value.length <= 2) {
                              return ("من فضلك أدخل الاسم بشكل صحيح");
                            } else
                              return null;
                          },
                          controller: dayController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "يوم السبت",
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "تاريخ الحجز",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (value.length <= 5 ||
                                !value.contains('/')) {
                              return ("من فضلك أدخل الاسم بشكل صحيح");
                            } else
                              return null;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: "2023/8/26",
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "وقت الحجز",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'هذا الحقل مطلوب';
                            } else if (value.length <= 2 ||
                                !value.contains(':')) {
                              return ("من فضلك أدخل الوقت بشكل صحيح");
                            } else
                              return null;
                          },
                          controller: TimeController,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: "20:20",
                            hintTextDirection: TextDirection.rtl,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: SizedBox(
                    width: 311,
                    height: 48,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff407BFF)),
                        onPressed: () {
                          appointmentBooking();
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.blueAccent,
                                  content: Text(
                                    'تم حجز الموعد وستصلك رسالة لتاكيد او رفض الحجز',
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
                                  'فشل حجز موعد',
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
                          "تأكيد الحجز",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void check() {
    print(emailController.toString());
    print(nameController.toString());
    print(dayController.toString());
    print(dateController.toString());
    print(timeController.toString());
  }
}
