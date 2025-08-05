import 'package:http/http.dart' as http;

import '../basics/api_url.dart';

class LogoutService {
  Future<bool> logout(String token) async {
    final url = Uri.parse("${ServerConfiguration.domainNameServer}/api/customer/logout");

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // ✅ أرسل التوكن هنا
      },
    );

    if (response.statusCode == 200) {
      print('🟡 نجاح: تم تسجيل الخروج من السيرفر');
      return true;
    } else {
      print('🔴 فشل في تسجيل الخروج: ${response.statusCode}');
      return false;
    }
  }
}
