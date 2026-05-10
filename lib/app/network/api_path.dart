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
}
