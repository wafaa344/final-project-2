import 'package:get/get.dart';

import '../native_service/secure_storage.dart';
import 'PreviousProjectsModel.dart';
import 'PreviousProjectsService.dart';

class PreviousProjectsController extends GetxController {
  final ProjectService _service = ProjectService();
  late SecureStorage storage = SecureStorage();
  var isLoading = true.obs;
  var projects = <PreviousProjectsModel>[].obs;
  String? token;

  Future<List<PreviousProjectsModel>> fetchCompanyProjects(int companyId) async {
    try {

      token = await storage.read('token');

      if (token == null) throw Exception("Token is null");

      final fetchedProjects = await _service.fetchProjectsByCompanyId(token!, companyId);
      return fetchedProjects;
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }


}
