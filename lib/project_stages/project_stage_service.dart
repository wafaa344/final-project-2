// lib/services/project_stage_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rebuild_flat/project_stages/project_stage_model.dart';
import '../basics/api_url.dart';
import '../native_service/secure_storage.dart';

class ProjectStageService {
  static Future<List<ProjectStageModel>> fetchStages(int projectId) async {
    final token = await SecureStorage().read('token');
    final url = '${ServerConfiguration.domainNameServer}/api/projectStages/$projectId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'] ?? [];

      return data.map((json) => ProjectStageModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في تحميل مراحل المشروع');
    }
  }
}
