import 'package:get/get.dart';

import 'get_projects_model.dart';
import 'get_projects_service.dart';

class ProjectController extends GetxController {
  var isLoading = true.obs;
  var projectList = <Project>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  void loadProjects() async {
    try {
      isLoading(true);
      var projects = await ProjectService().fetchProjects();
      projectList.assignAll(projects);
    } catch (e) {
      print('Error loading projects: $e');
    } finally {
      isLoading(false);
    }
  }
}
