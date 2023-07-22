import 'package:flutter/material.dart';
import 'package:patientapp/auth/signin_screen.dart';

import '../View/home_screen.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn;
    if (true) {
      return HomeScreen();
    } else
      return LoginScreen();
  }
}
