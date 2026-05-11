class CoachingListRequestParams {
  final int page;
  final int limit;
  final String query;

  CoachingListRequestParams({
    this.page = 1,
    this.limit = 10,
    this.query = '',
  });

  Map<String, dynamic> get toJson => {
    'page': 1,
    'limit': limit,
    if (query.isNotEmpty) 'search': query,
  };
}
