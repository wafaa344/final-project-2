import 'package:get/get.dart';
import 'PreviousProjectsController.dart';
class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviousProjectsController>(() => PreviousProjectsController());
  }
}
