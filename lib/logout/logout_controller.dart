import 'package:get/get.dart';
import '../native_service/secure_storage.dart';
import '../getstarted/get_started_screen.dart';
import 'logout_service.dart';

class LogoutController extends GetxController {
  final SecureStorage _secureStorage = SecureStorage();
  final LogoutService _logoutService = LogoutService();

  Future<void> logout() async {
    final token = await _secureStorage.read('token');

    if (token != null) {
      final success = await _logoutService.logout(token);
      if (success) {
        await _secureStorage.delete();
        Get.offAll(() => const GetStartedScreen());
      } else {
        Get.snackbar('خطأ', 'فشل تسجيل الخروج من السيرفر');
        await _secureStorage.delete();
        Get.offAll(() => const GetStartedScreen());
      }
    } else {
      Get.snackbar('خطأ', 'لم يتم العثور على التوكن');
      await _secureStorage.delete();
      Get.offAll(() => const GetStartedScreen());
    }
  }
}
