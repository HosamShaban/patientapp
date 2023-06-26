import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patientapp/View/personal_screen.dart';
import 'package:patientapp/controller/screenIndexProvider.dart';
import 'package:patientapp/onboarding.dart';
import 'package:patientapp/widget/loading_animation_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _checkEmailExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email != null;
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => screenIndexProvider())
          ],
          child: MaterialApp(
            home: FutureBuilder<String?>(
              future: _getToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingAnimationPage();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return PersonalPage(); // Replace with your home screen widget
                } else {
                  return const OnBoarding();
                }
              },
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Tajawal'),
          ),
        );
      },
    );
  }
}
