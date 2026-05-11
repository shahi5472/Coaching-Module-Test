import 'package:equatable/equatable.dart';

class CoachingDetailsResponseModel extends Equatable {
  final CoachingDetails coachingDetails;
  final List<Session> sessions;
  final FeedData feedData;
  final CurrentSession currentSession;

  const CoachingDetailsResponseModel({
    this.coachingDetails = const CoachingDetails(),
    this.sessions = const [],
    this.feedData = const FeedData(),
    this.currentSession = const CurrentSession(),
  });

  factory CoachingDetailsResponseModel.empty() {
    return const CoachingDetailsResponseModel();
  }

  CoachingDetailsResponseModel copyWith({
    CoachingDetails? coachingDetails,
    List<Session>? sessions,
    FeedData? feedData,
    CurrentSession? currentSession,
  }) {
    return CoachingDetailsResponseModel(
      coachingDetails: coachingDetails ?? this.coachingDetails,
      sessions: sessions ?? this.sessions,
      feedData: feedData ?? this.feedData,
      currentSession: currentSession ?? this.currentSession,
    );
  }

  factory CoachingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return CoachingDetailsResponseModel(
      coachingDetails: json['coaching_details'] != null ? CoachingDetails.fromJson(json['coaching_details']) : const CoachingDetails(),
      sessions: json['sessions'] != null ? (json['sessions'] as List).map((item) => Session.fromJson(item)).toList() : [],
      feedData: json['feed_data'] != null ? FeedData.fromJson(json['feed_data']) : const FeedData(),
      currentSession: json['current_session'] != null ? CurrentSession.fromJson(json['current_session']) : const CurrentSession(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coaching_details': coachingDetails.toJson(),
      'sessions': sessions.map((item) => item.toJson()).toList(),
      'feed_data': feedData.toJson(),
      'current_session': currentSession.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    coachingDetails,
    sessions,
    feedData,
    currentSession,
  ];
}

class CoachingDetails extends Equatable {
  final int id;
  final String title;
  final String desc;
  final String featureImg;
  final String bannerImg;
  final String settings;
  final String accessibilityStatus;
  final String type;
  final int userId;
  final int schoolId;
  final String startDate;
  final String endDate;
  final CoachingMeta meta;

  const CoachingDetails({
    this.id = 0,
    this.title = '',
    this.desc = '',
    this.featureImg = '',
    this.bannerImg = '',
    this.settings = '',
    this.accessibilityStatus = '',
    this.type = '',
    this.userId = 0,
    this.schoolId = 0,
    this.startDate = '',
    this.endDate = '',
    this.meta = const CoachingMeta(),
  });

  factory CoachingDetails.empty() {
    return const CoachingDetails();
  }

  CoachingDetails copyWith({
    int? id,
    String? title,
    String? desc,
    String? featureImg,
    String? bannerImg,
    String? settings,
    String? accessibilityStatus,
    String? type,
    int? userId,
    int? schoolId,
    String? startDate,
    String? endDate,
    CoachingMeta? meta,
  }) {
    return CoachingDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      featureImg: featureImg ?? this.featureImg,
      bannerImg: bannerImg ?? this.bannerImg,
      settings: settings ?? this.settings,
      accessibilityStatus: accessibilityStatus ?? this.accessibilityStatus,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      schoolId: schoolId ?? this.schoolId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      meta: meta ?? this.meta,
    );
  }

  factory CoachingDetails.fromJson(Map<String, dynamic> json) {
    return CoachingDetails(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      featureImg: json['featureImg'] ?? '',
      bannerImg: json['bannerImg'] ?? '',
      settings: json['settings'] ?? '',
      accessibilityStatus: json['accessibilityStatus'] ?? '',
      type: json['type'] ?? '',
      userId: json['userId'] ?? 0,
      schoolId: json['schoolId'] ?? 0,
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      meta: json['meta'] != null ? CoachingMeta.fromJson(json['meta']) : const CoachingMeta(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'featureImg': featureImg,
      'bannerImg': bannerImg,
      'settings': settings,
      'accessibilityStatus': accessibilityStatus,
      'type': type,
      'userId': userId,
      'schoolId': schoolId,
      'startDate': startDate,
      'endDate': endDate,
      'meta': meta.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    desc,
    featureImg,
    bannerImg,
    settings,
    accessibilityStatus,
    type,
    userId,
    schoolId,
    startDate,
    endDate,
    meta,
  ];
}

class CoachingMeta extends Equatable {
  final int membersCount;

  const CoachingMeta({
    this.membersCount = 0,
  });

  factory CoachingMeta.empty() {
    return const CoachingMeta();
  }

  CoachingMeta copyWith({
    int? membersCount,
  }) {
    return CoachingMeta(
      membersCount: membersCount ?? this.membersCount,
    );
  }

  factory CoachingMeta.fromJson(Map<String, dynamic> json) {
    return CoachingMeta(
      membersCount: json['members_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'members_count': membersCount,
    };
  }

  @override
  List<Object?> get props => [
    membersCount,
  ];
}

class Session extends Equatable {
  final int id;
  final String sessionName;
  final int completionRequired;
  final int isCompleted;
  final int isCurrent;
  final int parentId;
  final String sessionDate;
  final int batchId;
  final String weekBased;
  final int dripDays;
  final int isReordered;
  final int position;

  const Session({
    this.id = 0,
    this.sessionName = '',
    this.completionRequired = 0,
    this.isCompleted = 0,
    this.isCurrent = 0,
    this.parentId = 0,
    this.sessionDate = '',
    this.batchId = 0,
    this.weekBased = '',
    this.dripDays = 0,
    this.isReordered = 0,
    this.position = 0,
  });

  factory Session.empty() {
    return const Session();
  }

  Session copyWith({
    int? id,
    String? sessionName,
    int? completionRequired,
    int? isCompleted,
    int? isCurrent,
    int? parentId,
    String? sessionDate,
    int? batchId,
    String? weekBased,
    int? dripDays,
    int? isReordered,
    int? position,
  }) {
    return Session(
      id: id ?? this.id,
      sessionName: sessionName ?? this.sessionName,
      completionRequired: completionRequired ?? this.completionRequired,
      isCompleted: isCompleted ?? this.isCompleted,
      isCurrent: isCurrent ?? this.isCurrent,
      parentId: parentId ?? this.parentId,
      sessionDate: sessionDate ?? this.sessionDate,
      batchId: batchId ?? this.batchId,
      weekBased: weekBased ?? this.weekBased,
      dripDays: dripDays ?? this.dripDays,
      isReordered: isReordered ?? this.isReordered,
      position: position ?? this.position,
    );
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] ?? 0,
      sessionName: json['sessionName'] ?? '',
      completionRequired: json['completionRequired'] ?? 0,
      isCompleted: json['isCompleted'] ?? 0,
      isCurrent: json['isCurrent'] ?? 0,
      parentId: json['parentId'] ?? 0,
      sessionDate: json['sessionDate'] ?? '',
      batchId: json['batchId'] ?? 0,
      weekBased: json['weekBased'] ?? '',
      dripDays: json['dripDays'] ?? 0,
      isReordered: json['isReordered'] ?? 0,
      position: json['position'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionName': sessionName,
      'completionRequired': completionRequired,
      'isCompleted': isCompleted,
      'isCurrent': isCurrent,
      'parentId': parentId,
      'sessionDate': sessionDate,
      'batchId': batchId,
      'weekBased': weekBased,
      'dripDays': dripDays,
      'isReordered': isReordered,
      'position': position,
    };
  }

  @override
  List<Object?> get props => [
    id,
    sessionName,
    completionRequired,
    isCompleted,
    isCurrent,
    parentId,
    sessionDate,
    batchId,
    weekBased,
    dripDays,
    isReordered,
    position,
  ];
}

class FeedData extends Equatable {
  final FeedMeta meta;
  final List<dynamic> data;

  const FeedData({
    this.meta = const FeedMeta(),
    this.data = const [],
  });

  factory FeedData.empty() {
    return const FeedData();
  }

  FeedData copyWith({
    FeedMeta? meta,
    List<dynamic>? data,
  }) {
    return FeedData(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory FeedData.fromJson(Map<String, dynamic> json) {
    return FeedData(
      meta: json['meta'] != null ? FeedMeta.fromJson(json['meta']) : const FeedMeta(),
      data: json['data'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data,
    };
  }

  @override
  List<Object?> get props => [
    meta,
    data,
  ];
}

class FeedMeta extends Equatable {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String previousPageUrl;

  const FeedMeta({
    this.total = 0,
    this.perPage = 0,
    this.currentPage = 0,
    this.lastPage = 0,
    this.firstPage = 0,
    this.firstPageUrl = '',
    this.lastPageUrl = '',
    this.nextPageUrl = '',
    this.previousPageUrl = '',
  });

  factory FeedMeta.empty() {
    return const FeedMeta();
  }

  FeedMeta copyWith({
    int? total,
    int? perPage,
    int? currentPage,
    int? lastPage,
    int? firstPage,
    String? firstPageUrl,
    String? lastPageUrl,
    String? nextPageUrl,
    String? previousPageUrl,
  }) {
    return FeedMeta(
      total: total ?? this.total,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      firstPage: firstPage ?? this.firstPage,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      previousPageUrl: previousPageUrl ?? this.previousPageUrl,
    );
  }

  factory FeedMeta.fromJson(Map<String, dynamic> json) {
    return FeedMeta(
      total: json['total'] ?? 0,
      perPage: json['perPage'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
      firstPage: json['firstPage'] ?? 0,
      firstPageUrl: json['firstPageUrl'] ?? '',
      lastPageUrl: json['lastPageUrl'] ?? '',
      nextPageUrl: json['nextPageUrl'] ?? '',
      previousPageUrl: json['previousPageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'perPage': perPage,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'firstPage': firstPage,
      'firstPageUrl': firstPageUrl,
      'lastPageUrl': lastPageUrl,
      'nextPageUrl': nextPageUrl,
      'previousPageUrl': previousPageUrl,
    };
  }

  @override
  List<Object?> get props => [
    total,
    perPage,
    currentPage,
    lastPage,
    firstPage,
    firstPageUrl,
    lastPageUrl,
    nextPageUrl,
    previousPageUrl,
  ];
}

class CurrentSession extends Equatable {
  final int currentSessionId;
  final int currentSessionParentId;

  const CurrentSession({
    this.currentSessionId = 0,
    this.currentSessionParentId = 0,
  });

  factory CurrentSession.empty() {
    return const CurrentSession();
  }

  CurrentSession copyWith({
    int? currentSessionId,
    int? currentSessionParentId,
  }) {
    return CurrentSession(
      currentSessionId: currentSessionId ?? this.currentSessionId,
      currentSessionParentId: currentSessionParentId ?? this.currentSessionParentId,
    );
  }

  factory CurrentSession.fromJson(Map<String, dynamic> json) {
    return CurrentSession(
      currentSessionId: json['current_session_id'] ?? 0,
      currentSessionParentId: json['current_session_parent_id'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_session_id': currentSessionId,
      'current_session_parent_id': currentSessionParentId,
    };
  }

  @override
  List<Object?> get props => [
    currentSessionId,
    currentSessionParentId,
  ];
}
