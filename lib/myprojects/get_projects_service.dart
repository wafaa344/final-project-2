import 'dart:convert';
import 'package:http/http.dart' as http;

import '../basics/api_url.dart';
import '../native_service/secure_storage.dart';
import 'get_projects_model.dart';

class ProjectService {
  final String baseUrl = '${ ServerConfiguration.domainNameServer}/api/projects/myProject';

  Future<List<Project>> fetchProjects() async {
    final storage = SecureStorage();
    final token = await storage.read('token');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final projectsJson = data['data'] as List;

      return projectsJson.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
