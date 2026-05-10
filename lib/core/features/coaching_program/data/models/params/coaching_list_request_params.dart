class CoachingListRequestParams {
  final int page;
  final int limit;

  CoachingListRequestParams({
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> get toJson => {'page': 1, 'limit': limit};
}
