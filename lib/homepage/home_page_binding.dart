import 'package:get/get.dart';

import 'home_page_controller.dart';
class CompanyBindings implements Bindings {
  @override
  void dependencies() {
    print('HomeBinding is being called');
    Get.lazyPut<CompanyController>(() => CompanyController());
  }
}
