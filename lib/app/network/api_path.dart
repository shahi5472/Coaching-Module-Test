class APIModel {
  final String apiEndPoint;
  final String mockJsonEndPoint;
  final bool isMock;

  APIModel({
    required this.apiEndPoint,
    this.mockJsonEndPoint = "",
    this.isMock = false,
  });

  @override
  String toString() {
    return "ApiEndPoint :: [$apiEndPoint] :: MockJsonEndPoint :: [$mockJsonEndPoint] :: isMock :: [$isMock]";
  }
}

class APIPaths {
  APIPaths._();

  static APIModel apiName = APIModel(apiEndPoint: "", mockJsonEndPoint: "", isMock: false);

  static APIModel login = APIModel(apiEndPoint: "student/auth/login");

  static APIModel coachingList = APIModel(apiEndPoint: "student/coaching-programs/getEnrolledCoachingProgramList");

  static APIModel coachingDetails(int id) => APIModel(apiEndPoint: "coach/feeds/content/$id");

  static APIModel coachingFeedList({
    required int programId,
    required int sessionId,
  }) => APIModel(apiEndPoint: "/coach/feeds/get-all/$programId/session/$sessionId");

  static APIModel coachingNoteList = APIModel(apiEndPoint: "coach/feeds/coaching-notes-program-wise");
}
