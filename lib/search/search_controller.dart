import 'package:get/get.dart';
import '../homepage/company_model.dart';
import '../native_service/secure_storage.dart';
import 'search_service.dart';
import '../homepage/CompanyService.dart';

class MySearchController extends GetxController {
  final SearchService searchService;
  final CompanyService companyService = CompanyService();

  MySearchController(this.searchService);

  var query = ''.obs;
  var companies = <Company>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  String? token;

  final SecureStorage storage = SecureStorage();

  @override
  void onInit() {
    super.onInit();
    fetchAllCompanies();

    // ✅ استخدام debounce لتأخير البحث حتى يتوقف المستخدم عن الكتابة
    debounce(query, (_) {
      if (query.value.trim().isEmpty) {
        fetchAllCompanies();
      } else {
        refreshSearch();
      }
    }, time: const Duration(milliseconds: 500));
  }

  void onQueryChanged(String q) {
    query.value = q.trim();
  }

  /// ✅ تحميل جميع الشركات بدون فلترة
  Future<void> fetchAllCompanies() async {
    isLoading(true);
    token = await storage.read('token');

    if (token != null) {
      final result = await companyService.fetchCompanies(token!);
      if (result != null && result.success) {
        companies.assignAll(result.data);
        lastPage.value = 1;
        currentPage.value = 1;
      } else {
        companies.clear();
      }
    }

    isLoading(false);
  }


  Future<void> refreshSearch() async {
    if (isLoading.value) return;
    currentPage.value = 1;
    companies.clear();
    await _fetchPage();
  }


  Future<void> loadNextPage() async {
    if (query.isEmpty) return;
    if (isLoading.value) return;
    if (currentPage.value >= lastPage.value) return;

    currentPage.value++;
    await _fetchPage();
  }


  Future<void> _fetchPage() async {
    token = await storage.read('token');
    if (token != null) {
      try {
        isLoading.value = true;

        final response = await searchService.search(
          token: token!,
          query: query.value,
          page: currentPage.value,
        );

        lastPage.value = response.lastPage;


        final newCompanies = response.data;
        for (var company in newCompanies) {
          if (!companies.any((c) => c.id == company.id)) {
            companies.add(company);
          }
        }
      } catch (e) {
        print('Search error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
