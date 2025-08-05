import '../homepage/company_model.dart';

class SearchResponse {
  final int currentPage, lastPage, perPage, total;
  final List<Company> data;

  SearchResponse({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final meta = json['data'];
    return SearchResponse(
      currentPage: meta['current_page'],
      lastPage: meta['last_page'],
      perPage: meta['per_page'],
      total: meta['total'],
      data: (meta['data'] as List).map((e) => Company.fromJson(e)).toList(),
    );
  }
}
