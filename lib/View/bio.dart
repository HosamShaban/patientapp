import 'package:flutter/material.dart';
import 'package:patientapp/View/Biography.dart';
import 'package:patientapp/View/profile_screen.dart';
import 'package:patientapp/View/view_attachments.dart';

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
          bottom: TabBar(tabs: [
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
        body: TabBarView(children: [Biography(), ViewMyAttachments()]),
      ),
    );
  }
}
