import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patientapp/config/constants.dart';
import 'package:patientapp/features/main/presentation/controller/screenIndexProvider.dart';
import 'package:patientapp/features/main/presentation/view/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/dio_helper.dart';
import 'features/splash/presentation/view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(
        Constants.deviceWidth,
        Constants.deviceHeight,
      ),
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
                  return const SplashScreen();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return MainScreen(); // Replace with your home screen widget
                } else {
                  return const SplashScreen();
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
