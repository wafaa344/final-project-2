// survey_binding.dart
import 'package:get/get.dart';
import 'cost/cost_binding.dart';
import 'survey_controller.dart';
import 'survey_service.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() {
    final service = SurveyService();
    final controller = SurveyController(service);
    Get.put(controller);
    final args = Get.arguments as List<int>;
    controller.loadSurveyQuestions(args);
    CostBinding().dependencies();
  }
}
