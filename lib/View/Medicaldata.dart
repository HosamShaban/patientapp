import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:patientapp/Model/Personaldata_model.dart';
import 'package:patientapp/View/Biography.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Consts/colors.dart';

class Medicaldata extends StatefulWidget {
  const Medicaldata({Key? key}) : super(key: key);

  @override
  State<Medicaldata> createState() => _MedicaldataState();
}

class _MedicaldataState extends State<Medicaldata> {
  String Diabetictype = "one";
  late PersonalModel patient;

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
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? filePath = _prefs?.getString('pdfFilePath');
    if (filePath != null) {
      setState(() {
        _pdfFile = File(filePath);
        _fileAdded = true;
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
        _fileAdded = true;
        _saveFilePath(_pdfFile!.path);
      });
    }
  }

  _saveFilePath(String filePath) async {
    _prefs?.setString('pdfFilePath', filePath);
  }

  _removeFilePath() {
    _prefs?.remove('pdfFilePath');
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
          "البيانات الطبية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 230, top: 25),
                  child: const Text(
                    "نوع السكري",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("النوع الثاني",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Radio(
                      activeColor: Colors.black,
                      value: "second",
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
                      value: "first",
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
                margin: const EdgeInsets.only(left: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("لا أعرف",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Radio(
                      activeColor: Colors.black,
                      value: "dont know",
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
                      value: "Pregnancy",
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
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 170),
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
                height: 25,
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
                    _removeFilePath();
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
                              "السيرة المرضية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Biography())),
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
