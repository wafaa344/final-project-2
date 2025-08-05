import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../basics/api_url.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _verifyUrl = '${ServerConfiguration.domainNameServer}/api/verifyAccount';

  static Future<bool> verifyCode(String code) async {
    final token = await _storage.read(key: 'token');

    if (token == null)
      print("توكن غير موجود");



    final response = await http.post(
      Uri.parse(_verifyUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'code': code}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("فشل التحقق من الرمز");
    }
  }
  static Future<void> resendCode() async {
    final token = await _storage.read(key: 'token');

    if (token == null) throw Exception("توكن غير موجود");

    final response = await http.get(
      Uri.parse('${ServerConfiguration.domainNameServer}/api/resendCode'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("فشل في إعادة إرسال الكود");
    }
  }

}
