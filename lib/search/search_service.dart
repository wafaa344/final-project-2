import 'dart:convert';
import 'package:http/http.dart' as http;
import 'search_model.dart';

class SearchService {
  final String baseUrl;

  SearchService({required this.baseUrl});

  Future<SearchResponse> search({required String token, required String query, int page = 1}) async {
    final uri = Uri.parse('$baseUrl/api/companies/search?page=$page');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',},
      body: jsonEncode({'search': query}),
    );

    print("Status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("dfaefaesfcasfcsaf");
      final data = jsonDecode(response.body);
      return SearchResponse.fromJson(data);
    } else {
      throw Exception('فشل تحميل نتائج البحث');
    }
  }
}
