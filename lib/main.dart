import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/routes.dart';
import 'basics/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  //Stripe.publishableKey = ServerConfiguration.public_key;
  //await Stripe.instance.applySettings();

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
