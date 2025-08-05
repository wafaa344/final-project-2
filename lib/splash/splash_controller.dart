import 'dart:async';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../homepage/home_page_screen.dart';
import '../getstarted/get_started_screen.dart';
import '../native_service/secure_storage.dart';

class SplashController extends GetxController {
  final SecureStorage _secureStorage = SecureStorage();
  final storage = SecureStorage();
  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));

    final token = await _secureStorage.read('token');

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAll(() => const GetStartedScreen());
    }
  }
}
