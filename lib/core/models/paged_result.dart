/// Domain-side page of results (maps from the backend `PagedResponse<T>`).
class PagedResult<T> {
  const PagedResult({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.hasMore,
  });

  final List<T> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final bool hasMore;
}
