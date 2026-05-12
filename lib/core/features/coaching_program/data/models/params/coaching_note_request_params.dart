class CoachingNoteRequestParams {
  final int coachingProgramId;
  final int page;
  final int limit;

  CoachingNoteRequestParams({
    required this.coachingProgramId,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> get toJson => {
    'coaching_program_id': coachingProgramId,
    'page': page,
    'limit': limit,
  };
}
