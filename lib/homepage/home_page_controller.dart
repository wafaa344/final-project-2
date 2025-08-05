import 'package:get/get.dart';

import '../native_service/secure_storage.dart';
import 'CompanyService.dart';
import 'company_model.dart';


class CompanyController extends GetxController {
  var companies = <Company>[].obs;
  late SecureStorage storage = SecureStorage();
  var isLoading = true.obs;
  String? token;
  final CompanyService _service = CompanyService();

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    isLoading(true);
    token = await storage.read('token');

    if (token != null) {
      final response = await _service.fetchCompanies(token!);

      if (response != null && response.success) {
        companies.assignAll(response.data);
      } else {
        print("فشل في تحميل الشركات");
      }
    }

    isLoading(false);
  }

}
