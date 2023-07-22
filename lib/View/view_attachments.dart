import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Consts/colors.dart';

class ViewMyAttachments extends StatefulWidget {
  const ViewMyAttachments({super.key});

  @override
  State<ViewMyAttachments> createState() => _ViewMyAttachmentsState();
}

class _ViewMyAttachmentsState extends State<ViewMyAttachments> {
  Map<String, dynamic> bio = {};
  final String baseUrl = "https://diabetes-23.000webhostapp.com";
  final String fileurl =
      "https://diabetes-23.000webhostapp.com/api/patient/attachments";
  void FetchPatintDataFromApi() async {
    final Dio dio = Dio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      dio.options.headers["Authorization"] = "Bearer $token";
      var response = await dio.get("$baseUrl/api/patient/profile");
      if (response.statusCode == 200) {
        setState(() {
          bio = response.data;
        });
      }
      print(response.data);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    FetchPatintDataFromApi();
  }

  @override
  void dispose() {
    bio.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bio.isEmpty
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
                itemCount: bio['data']['attachments'].length,
                itemBuilder: (context, index) {
                  final Bio = bio['data']['attachments'][index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ConstColors.primaryColor,
                    ),
                    child: InkWell(
                      onTap: () async {
                        launch('$fileurl/${Bio['filepath']}');
                        /*
                        String file =
                            'https://docs.google.com/gview?embedded=true&url=$fileurl/${Bio['filepath']}';

                        print(file);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewFike(
                                      path: file,
                                    )));*/
                      },
                      child: ListTile(
                        title: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                          context: context,
                                          animType: AnimType.scale,
                                          dialogType: DialogType.question,
                                          body: const Center(
                                            child: Text(
                                              'هل تريد حذف هذا الملف ؟',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          btnOk: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () async {
                                                final Dio dio = Dio();
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var token =
                                                    prefs.getString('token');
                                                dio.options.headers = {
                                                  'Authorization':
                                                      'Bearer $token'
                                                };
                                                var response = await dio.post(
                                                    "$baseUrl/api/patient/deleteAttachments/${Bio['id']}",
                                                    data: {});
                                                print(response.data);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                      'تم حذف الملف',
                                                      style: TextStyle(
                                                        fontFamily: 'Tajawal',
                                                        fontSize: 20,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "نعم",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ))).show();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 170),
                                  child: const Text(
                                    " : اسم الملف",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ' ${Bio['filename']}',
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  ' ${Bio['created_at']}'.substring(12, 17),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const Text(
                                  " : الوقت",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  ' ${Bio['created_at']}'.substring(0, 11),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                const Text(
                                  " : تاريخ الرفع",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
