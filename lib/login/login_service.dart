import 'dart:convert';
import 'package:http/http.dart' as http;

import '../basics/api_url.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ServerConfiguration.domainNameServer}/api/customer/login');
    print('🔵 محاولة الاتصال بـ: $url');
    print('📧 البريد: $email، 🔑 كلمة السر: $password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('🟡 حالة الاستجابة: ${response.statusCode}');
      print('📦 محتوى الاستجابة: ${response.body}');

      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print('🔴 حدث خطأ أثناء الاتصال: $e');
      rethrow;
    }
  }}
