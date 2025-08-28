import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_flat/notification/notification_service.dart';
import 'Routes/routes.dart';
import 'basics/app_colors.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await  FirebaseMsg().initFcm();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crafty App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        fontFamily: 'Arial',
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
