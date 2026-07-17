import '../models/paged_result.dart';

/// Parses the backend `PagedResponse<T>` envelope (API ref §1) into a domain
/// [PagedResult]. [itemMapper] converts each raw JSON item to a `T`.
PagedResult<T> parsePagedResponse<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic> item) itemMapper,
) {
  final rawItems = json['items'] as List<dynamic>? ?? <dynamic>[];
  return PagedResult<T>(
    items: rawItems
        .map((e) => itemMapper(e as Map<String, dynamic>))
        .toList(growable: false),
    pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
    pageSize: (json['pageSize'] as num?)?.toInt() ?? rawItems.length,
    totalCount: (json['totalCount'] as num?)?.toInt() ?? rawItems.length,
    hasMore: json['hasMore'] as bool? ?? false,
  );
}
