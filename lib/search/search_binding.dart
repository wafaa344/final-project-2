import 'package:get/get.dart';
import '../basics/api_url.dart';
import 'search_service.dart';
import 'search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchService(baseUrl: ServerConfiguration.domainNameServer));
    Get.lazyPut(() => MySearchController(Get.find<SearchService>()));
  }
}
