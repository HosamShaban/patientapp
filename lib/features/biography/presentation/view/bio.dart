import 'package:flutter/material.dart';
import 'package:patientapp/features/biography/presentation/view/Biography.dart';
import 'package:patientapp/features/medical_data/presentation/view/view_attachments.dart';
import 'package:patientapp/features/profile/presentation/view/profile_screen.dart';

class BioTabBar extends StatelessWidget {
  const BioTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            "السيرة المرضية",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          bottom: const TabBar(tabs: [
            Tab(
              child: Text(
                "سجل التشخيصات",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
              ),
            ),
            Tab(
              child: Text(
                "سجل المرفقات",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [Biography(), const ViewMyAttachments()]),
      ),
    );
  }
}
