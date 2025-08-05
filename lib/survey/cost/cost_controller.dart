import 'package:get/get.dart';
import '../../native_service/secure_storage.dart';
import 'cost_service.dart';
import 'cost_model.dart';

class CostController extends GetxController {
  final CostService service;
  late SecureStorage storage = SecureStorage();
  String? token;
  CostController(this.service);

  var isLoading = false.obs;


  Future<double> calculateCostOnly(CostRequest request) async {
    try {
      isLoading.value = true;
      token = await storage.read('token');
      final result = await service.calculateCost(token!,request);
      return result.totalPrice;
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
      return 0;
    } finally {
      isLoading.value = false;
    }
  }
}
