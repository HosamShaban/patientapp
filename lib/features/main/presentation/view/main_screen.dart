import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/Defaultimages.dart';
import 'package:patientapp/core/resources/colors.dart';
import 'package:patientapp/core/widget/tab_card.dart';
import 'package:patientapp/features/appointment/presentation/view/tabs.dart';
import 'package:patientapp/features/doctors/presentation/view/doctor_screen.dart';
import 'package:patientapp/features/home/presentation/view/home_screen.dart';
import 'package:patientapp/features/main/presentation/controller/screenIndexProvider.dart';
import 'package:patientapp/features/measure/presentation/view/measure_screen.dart';
import 'package:patientapp/features/profile/presentation/view/profile_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final ScaffoldState scaffoldState;

  @override
  void initState() {
    context.read<screenIndexProvider>().tabFlag = 0;
    super.initState();
  }

  List<dynamic> screens = [
    const HomeScreen(),
    const MyTabBar(),
    const DoctorScreen(),
    const ProfileScreen(),
    const SugarMeasurement()
  ];

  @override
  Widget build(BuildContext context) {
    final _screenindexprovider = Provider.of<screenIndexProvider>(context);
    int currentScreenIndex = _screenindexprovider.tabFlag;
    return Scaffold(
      body: screens[currentScreenIndex],
      bottomNavigationBar: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: ConstColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.04),
              offset: const Offset(0, -2),
            ),
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.10),
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabCard(
              color: currentScreenIndex == 4
                  ? ConstColors.whiteFontColor
                  : const Color(0xffbdb7b7),
              image: DefaultImages.measure,
              title: "قياس السكر",
              onTap: () {
                setState(() {
                  _screenindexprovider.tabFlag = 4;
                });
              },
            ),
            TabCard(
              color: currentScreenIndex == 1
                  ? ConstColors.whiteFontColor
                  : const Color(0xffbdb7b7),
              image: DefaultImages.date,
              title: "مواعيدي",
              onTap: () {
                setState(() {
                  _screenindexprovider.tabFlag = 1;
                });
              },
            ),
            TabCard(
              color: currentScreenIndex == 0
                  ? ConstColors.whiteFontColor
                  : const Color(0xffbdb7b7),
              image: DefaultImages.home,
              title: "الرئيسية",
              onTap: () {
                setState(() {
                  _screenindexprovider.tabFlag = 0;
                });
              },
            ),
            TabCard(
              color: currentScreenIndex == 2
                  ? ConstColors.whiteFontColor
                  : const Color(0xffbdb7b7),
              image: DefaultImages.doctors,
              title: "الأطباء",
              onTap: () {
                setState(() {
                  _screenindexprovider.tabFlag = 2;
                });
              },
            ),
            TabCard(
              color: currentScreenIndex == 3
                  ? ConstColors.whiteFontColor
                  : const Color(0xffbdb7b7),
              image: DefaultImages.profile,
              title: "صفحتي",
              onTap: () {
                setState(() {
                  _screenindexprovider.tabFlag = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
