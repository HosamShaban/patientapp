import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:patientapp/Model/Personaldata_model.dart';
import 'package:patientapp/View/Biography.dart';
import 'package:patientapp/View/show_mid_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Consts/colors.dart';

class Medicaldata extends StatefulWidget {
  const Medicaldata({Key? key}) : super(key: key);

  @override
  State<Medicaldata> createState() => _MedicaldataState();
}

class _MedicaldataState extends State<Medicaldata> {
  String Diabetictype = "Type 1 Diabetes";
  TextEditingController status = TextEditingController();
  late PersonalModel patient;
  final String baseUrl = "https://diabete-23.000webhostapp.com";
  String selectval = "male";

  Future<void> StoreUserMedicalData() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var response = await dio.post("$baseUrl/api/patient/updateProfile", data: {
      "diabetic_type": Diabetictype,
      "patient_status": status.text.trim(),
      "gender": selectval
    });

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

  Future uploaudFileToApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio.options.headers = {'Authorization': 'Bearer $token'};
    var file = await dio.post("$baseUrl/api/patient/storeAttachments",
        data: {"attachment": Diabetictype, "fileName": "diagnosis"});
    print(file.data);
  }

  final _formKey = GlobalKey<FormState>();
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
          "البيانات الطبية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 260, top: 23),
                    child: const Text(
                      "نوع السكري",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 130),
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
                  margin: const EdgeInsets.only(left: 130),
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
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "الجنس",
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton(
                                hint: Text("اختر"),
                                items: <String>[
                                  'male',
                                  'female',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectval = value!;
                                  });
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color(0xffEAEAEA),
                      borderRadius: BorderRadius.circular(12.0)),
                  width: 327,
                  height: 108,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    controller: status,
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
                    "المرفقات (اختياري)",
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
                        : 'تحاليل او تشخيصات سابقة .pdf'),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            uploadFileToApi();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: const Color(0xFF000000),
                          )),
                      Container(
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
                    ],
                  ),
                ),
                /* Container(
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
                                "رفع الملف",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            uploadFileToApi();
                          },
                        ),
                      ),
                    ],
                  ),
                ),*/
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
                                "حفظ البيانات",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              StoreUserMedicalData();
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
                                    builder: (context) => ShowMedicalData()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadFileToApi() async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    dio.options.headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data"
    };

    if (_pdfFile != null) {
      FormData formData = FormData.fromMap({
        'attachment': await MultipartFile.fromFile(
          _pdfFile!.path,
          filename: _pdfFile!.path.split('/').last,
        ),
        'fileName': _pdfFile!.path.split('/').last,
      });

      var response = await dio.post(
        "$baseUrl/api/patient/storeAttachments",
        data: formData,
      );
      print(response.data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'تم رفع الملف بنجاح',
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
                'فشل رفع الملف',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )),
        );
      }
    }
  }
}
