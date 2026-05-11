class GetCoachingDetailsRequestParams {
  final int programId;
  final String timeZone;

  GetCoachingDetailsRequestParams({
    required this.programId,
    required this.timeZone,
  });

  Map<String, dynamic> get toJson => {"user_zone": timeZone};
}
