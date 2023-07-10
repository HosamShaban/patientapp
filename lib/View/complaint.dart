import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:patientapp/Model/Personaldata_model.dart';
import 'package:patientapp/View/Biography.dart';
import 'package:patientapp/View/show_mid_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Consts/colors.dart';

class complaint extends StatefulWidget {
  const complaint({Key? key}) : super(key: key);

  @override
  State<complaint> createState() => _MedicaldataState();
}

class _MedicaldataState extends State<complaint> {
  String Diabetictype = "Type 1 Diabetes";
  late PersonalModel patient;
  final String baseUrl = "https://diabete-23.000webhostapp.com";
  String selectval = "male";

  Future<void> StoreUserMedicalData() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post("$baseUrl/api/patient/updateProfile",
        data: {"diabetic_type": Diabetictype, "gender": selectval});

    print(response.data);
  }

  void yourFunctionName() {
    patient = PersonalModel(
      id: patient.id,
      diagnosis: patient.diagnosis,
      treatment: patient.treatment,
    );
  }

  File? _pdfFile;
  bool _fileAdded = false;
  int _pageNumber = 1;
  PDFViewController? _pdfViewController;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
        _fileAdded = true;
      });
    }
  }

  void _removeFile() {
    setState(() {
      _pdfFile = null;
      _fileAdded = false;
    });
  }

  final Uri whatsapp = Uri.parse('https://wa.me/0568181703');
  final Uri telegram = Uri.parse('https://t.me/0568181703');
  Future uploaudFileToApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var file = await dio.post("$baseUrl/api/patient/storeAttachments",
        data: {"attachment": Diabetictype, "fileName": "diagnosis"});
    print(file.data);
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
          "الأعراض والمرفقات",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/doctor(2).png'),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified,
                    size: 15,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "اسم الطبيب : وائل علي",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 200),
                child: const Text(
                  "أوصف حالتك للطبيب",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
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
                    hintText: "اشرح للطبيب حالتك أو استفسارك باختصار",
                    hintTextDirection: TextDirection.rtl,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 220),
                child: const Text(
                  "المرفقات",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: IconButton(
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    size: 28,
                  ),
                  onPressed: () {
                    _removeFile();
                  },
                ),
                title: Container(
                  margin: const EdgeInsets.only(left: 75),
                  child: Text(_pdfFile != null
                      ? _pdfFile!.path.split('/').last
                      : 'ملف حالة المريض .pdf'),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_fileAdded ? 'تم اضافة الملف بنجاح' : ''),
                    if (_fileAdded)
                      const Icon(
                        Icons.done,
                        size: 12,
                      ),
                  ],
                ),
                trailing: _pdfFile != null
                    ? Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: PDFView(
                          filePath: _pdfFile!.path,
                          onViewCreated: (PDFViewController viewController) {
                            _pdfViewController = viewController;
                          },
                          onPageChanged: (page, total) {
                            setState(() {
                              _pageNumber = page!;
                            });
                          },
                        ),
                      )
                    : Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
              ),
              const SizedBox(height: 25),
              InkWell(
                onTap: _pickFile,
                child: Container(
                  width: 327,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xffEAEAEA),
                    border: Border.all(
                      color: const Color(0xFF000000),
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Text(
                      "اضافة ملف",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
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
                              "حفظ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          StoreUserMedicalData();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
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
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          launchUrl(whatsapp);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(image: AssetImage("assets/images/whats.png")),
                            SizedBox(width: 10),
                            Text(
                              'تحدث مع الطبيب',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void chat() {
    String number = '0568181703';
    String whatsApp =
        "whatsapp://send?phone=$number&text=${Uri.encodeFull('message')}";
    launchUrl(Uri.parse(whatsApp));
  }
}
