import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/Defaultimages.dart';

class FaildLogin extends StatelessWidget {
  const FaildLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(DefaultImages.faild),
            const Text(
              "",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            const Text(
              "فشل تسجيل دخولك",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            const Text(
              "فشل تسجيل دخولك",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            const Text(
              "فشل تسجيل دخولك",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
