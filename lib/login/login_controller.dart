import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';
import '../homepage/home_page_screen.dart';
import '../native_service/secure_storage.dart';
import 'login_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final LoginService _loginService = LoginService();
  final SecureStorage _secureStorage = SecureStorage();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول");
      return;
    }

    isLoading.value = true;
    try {
      final result = await _loginService.login(email, password);

      if (result['success'] == true) {
        final token = result['data']['token'];

        await _secureStorage.save('token', token);

        Get.snackbar("تم", result['message']);
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.snackbar("فشل", result['message']);
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ ما");
    } finally {
      isLoading.value = false;
    }
  }
}