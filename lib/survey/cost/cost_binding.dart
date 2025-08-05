import 'package:get/get.dart';
import 'cost_controller.dart';
import 'cost_service.dart';

class CostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CostService>(() => CostService());
    Get.lazyPut<CostController>(() => CostController(Get.find()));
  }
}
