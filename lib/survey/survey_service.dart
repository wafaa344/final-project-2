// survey_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../basics/api_url.dart';
import 'survey_model.dart';

class SurveyService {
  Future<List<ServiceModel>> fetchSurveyQuestions(String token,List<int> serviceIds) async {
    final url = Uri.parse('${ServerConfiguration.domainNameServer}/api/services/questions');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',},
      body: jsonEncode({'service_ids': serviceIds}),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List data = decoded['data'];
      return data.map((e) => ServiceModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في جلب الأسئلة');
    }
  }
}
