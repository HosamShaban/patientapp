import 'package:dio/dio.dart';
import 'package:patientapp/Model/all_doctors.dart';
import 'package:patientapp/Model/doctors_model.dart';
import 'package:patientapp/View/doctorprofile.dart';
import 'package:patientapp/View/filter_view.dart';
import 'package:patientapp/controller/doctors_controller.dart';
import 'package:patientapp/widget/doctors_card.dart';
import 'package:flutter/material.dart';

class DoctorScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const DoctorScreen({super.key, this.scaffoldKey});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final doctorController = DoctorsController();
  String query = '';
  String selectedFilter = 'All';
  List<AllDoctorsModel> doctors = [];
  final String baseUrl = "http://10.:8000";

  void FetchDoctorsFromApi() async {
    final Dio dio = Dio();

    try {
      var response = await dio.get("$baseUrl/api/patient/doctors");
      print(response.statusCode);
      print(response.data);
      var responseDtat = response.data as List;

      setState(() {
        doctors = responseDtat.map((e) => AllDoctorsModel.fromjson(e)).toList();
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  Future<void> Register() async {
    final Dio dio = Dio();
    var response = await dio.post("$baseUrl/api/patient/register", data: {
      "name": "mohammed",
      "email": "moh@gmail.com",
      "password": "18383832dd"
    });
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'الأطباء',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  Register();
                },
                child: Text("Fetch")),
            Row(
              children: [
                Material(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30))),
                        context: context,
                        builder: (context) => const FilterView(),
                      );
                    },
                    child: Image.asset(
                      'assets/images/filter.png',
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F4F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'بحث',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xffADAEB3),
                          fontWeight: FontWeight.w500,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xffADAEB3),
                            size: 30,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 210, top: 9),
                      ),
                      onChanged: (value) {
                        // Perform search
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: doctorController.doctorsList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final item = doctorController.doctorsList[index];
                  if (query.isNotEmpty &&
                      !item.title.toLowerCase().contains(query.toLowerCase())) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const doctorProfile(),
                          ),
                        );
                      },
                      child: DoctorsCard(
                        title: item.title,
                        image: item.image,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
