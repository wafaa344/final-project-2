import 'dart:convert';
import 'package:http/http.dart' as http;
import '../basics/api_url.dart';
import '../native_service/secure_storage.dart';

class ProfileService {
  final SecureStorage _secureStorage = SecureStorage();
  final String baseUrl = '${ServerConfiguration.domainNameServer}/api/customer/getprofile';

  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await _secureStorage.read('token');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل في تحميل الملف الشخصي');
    }
  }
  Future<void> updateProfile({
    String? name,
    int? age,
    String? gender,
    String? phone,
    String? imagePath,
  }) async {
    final token = await _secureStorage.read('token');

    final uri = Uri.parse('${ServerConfiguration.domainNameServer}/api/customer/profile');

    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

    if (name != null) request.fields['name'] = name;
    if (age != null) request.fields['age'] = age.toString();
    if (gender != null) request.fields['gender'] = gender;
    if (phone != null) request.fields['phone'] = phone;

    if (imagePath != null && imagePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    final response = await request.send();

    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      throw Exception('فشل التعديل: ${jsonDecode(body)['message'] ?? 'خطأ غير معروف'}');
    }
  }
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = await _secureStorage.read('token');
    final url = '${ServerConfiguration.domainNameServer}/api/customer/change-password';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode != 200 || responseData['success'] != true) {
      throw Exception(responseData['message'] ?? 'فشل تغيير كلمة المرور');
    }
  }


}