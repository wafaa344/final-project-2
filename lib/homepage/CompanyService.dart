import 'dart:convert';
import 'package:http/http.dart' as http;
import '../basics/api_url.dart';
import 'company_model.dart';


class CompanyService {
  var  url = Uri.parse('${ServerConfiguration.domainNameServer}/api/companies');

  Future<CompanyResponse?> fetchCompanies(String token) async {
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return CompanyResponse.fromJson(jsonData);
      } else {
        print('خطأ في الاتصال بالسيرفر: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('حدث خطأ أثناء جلب البيانات: $e');
      return null;
    }
  }

}
