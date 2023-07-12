import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patientapp/controller/firebase/controllers/fb_notificatons.dart';
import 'package:patientapp/controller/screenIndexProvider.dart';
import 'package:patientapp/firebase_options.dart';
import 'package:provider/provider.dart';

import 'View/splash.dart';
import 'controller/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await firebaseModule();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

firebaseModule() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FbNotifications fb = FbNotifications();
  await fb.requestNotificationPermissions();
  await fb.initializeForegroundNotificationForAndroid();
  await FbNotifications.initNotifications();
  fb.manageNotificationAction();
  print('object');
  print(await FirebaseMessaging.instance.getToken());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 781.0909090909091),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => screenIndexProvider())
          ],
          child: MaterialApp(
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Tajawal'),
          ),
        );
      },
    );
  }
}
