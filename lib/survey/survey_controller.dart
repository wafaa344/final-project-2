// survey_controller.dart
import 'package:get/get.dart';
import '../native_service/secure_storage.dart';
import 'survey_model.dart';
import 'survey_service.dart';

class SurveyController extends GetxController {
  final SurveyService service;
  late SecureStorage storage = SecureStorage();
  String? token;
  SurveyController(this.service);

  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;

  Future<void> loadSurveyQuestions(List<int> serviceIds) async {
    try {
      token = await storage.read('token');
      isLoading.value = true;
      if(token!=null){
      final data = await service.fetchSurveyQuestions(token!,serviceIds);
      services.assignAll(data);}
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Map<int, dynamic> answers = {};
}
