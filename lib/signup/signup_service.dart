import 'dart:convert';
import 'package:http/http.dart' as http;

import '../basics/api_url.dart';

class SignUpService {
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required int age,
    required String gender,
    String? phone,
  }) async {
    final url = Uri.parse('${ServerConfiguration.domainNameServer}/api/customer/register');
    final response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'age': age.toString(),
      'gender': gender == 'ذكر' ? 'male' : 'female',
      if (phone != null && phone.isNotEmpty) 'phone': phone,
    });
    return json.decode(response.body);
  }
}
