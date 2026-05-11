import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetFeedListResponseModel extends Equatable {
  final FeedListMeta meta;
  final List<FeedItem> data;
  final String coachingType;
  final int studentEnrollmentId;

  const GetFeedListResponseModel({
    this.meta = const FeedListMeta(),
    this.data = const [],
    this.coachingType = '',
    this.studentEnrollmentId = 0,
  });

  factory GetFeedListResponseModel.empty() {
    return const GetFeedListResponseModel();
  }

  GetFeedListResponseModel copyWith({
    FeedListMeta? meta,
    List<FeedItem>? data,
    String? coachingType,
    int? studentEnrollmentId,
  }) {
    return GetFeedListResponseModel(
      meta: meta ?? this.meta,
      data: data ?? this.data,
      coachingType: coachingType ?? this.coachingType,
      studentEnrollmentId: studentEnrollmentId ?? this.studentEnrollmentId,
    );
  }

  factory GetFeedListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFeedListResponseModel(
      meta: json['meta'] != null ? FeedListMeta.fromJson(json['meta']) : const FeedListMeta(),
      data: json['data'] != null ? (json['data'] as List).map((item) => FeedItem.fromJson(item)).toList() : [],
      coachingType: json['coaching_type'] ?? '',
      studentEnrollmentId: json['student_enrollment_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data.map((item) => item.toJson()).toList(),
      'coaching_type': coachingType,
      'student_enrollment_id': studentEnrollmentId,
    };
  }

  @override
  List<Object?> get props => [
    meta,
    data,
    coachingType,
    studentEnrollmentId,
  ];
}

class FeedListMeta extends Equatable {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String previousPageUrl;

  const FeedListMeta({
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

  factory FeedListMeta.empty() {
    return const FeedListMeta();
  }

  FeedListMeta copyWith({
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
    return FeedListMeta(
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

  factory FeedListMeta.fromJson(Map<String, dynamic> json) {
    return FeedListMeta(
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

class FeedItem extends Equatable {
  final int id;
  final int programId;
  final int userId;
  final String feedType;
  final int coachingSessionId;
  final String feedData;
  final int commentCount;
  final String createdAt;
  final String updatedAt;
  final int isNotified;
  final int communityFeedId;
  final int studentId;
  final int coachingLibraryId;
  final int liveSchedulerId;
  final String quizType;
  final String quizRandomizedSettings;
  final int isPremium;
  final int position;
  final String title;
  final String pinnedAt;
  final String files;
  final int parentFeedId;
  final int orderIndex;
  final int creatorId;
  final String settings;
  final Feed feed;
  final List<CoachingProgramSubmission> coachingProgramSubmission;
  final FeedItemMeta meta;

  const FeedItem({
    this.id = 0,
    this.programId = 0,
    this.userId = 0,
    this.feedType = '',
    this.coachingSessionId = 0,
    this.feedData = '',
    this.commentCount = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.isNotified = 0,
    this.communityFeedId = 0,
    this.studentId = 0,
    this.coachingLibraryId = 0,
    this.liveSchedulerId = 0,
    this.quizType = '',
    this.quizRandomizedSettings = '',
    this.isPremium = 0,
    this.position = 0,
    this.title = '',
    this.pinnedAt = '',
    this.files = '',
    this.parentFeedId = 0,
    this.orderIndex = 0,
    this.creatorId = 0,
    this.settings = '',
    this.feed = const Feed(),
    this.coachingProgramSubmission = const [],
    this.meta = const FeedItemMeta(),
  });

  factory FeedItem.empty() {
    return const FeedItem();
  }

  FeedItem copyWith({
    int? id,
    int? programId,
    int? userId,
    String? feedType,
    int? coachingSessionId,
    String? feedData,
    int? commentCount,
    String? createdAt,
    String? updatedAt,
    int? isNotified,
    int? communityFeedId,
    int? studentId,
    int? coachingLibraryId,
    int? liveSchedulerId,
    String? quizType,
    String? quizRandomizedSettings,
    int? isPremium,
    int? position,
    String? title,
    String? pinnedAt,
    String? files,
    int? parentFeedId,
    int? orderIndex,
    int? creatorId,
    String? settings,
    Feed? feed,
    List<CoachingProgramSubmission>? coachingProgramSubmission,
    FeedItemMeta? meta,
  }) {
    return FeedItem(
      id: id ?? this.id,
      programId: programId ?? this.programId,
      userId: userId ?? this.userId,
      feedType: feedType ?? this.feedType,
      coachingSessionId: coachingSessionId ?? this.coachingSessionId,
      feedData: feedData ?? this.feedData,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isNotified: isNotified ?? this.isNotified,
      communityFeedId: communityFeedId ?? this.communityFeedId,
      studentId: studentId ?? this.studentId,
      coachingLibraryId: coachingLibraryId ?? this.coachingLibraryId,
      liveSchedulerId: liveSchedulerId ?? this.liveSchedulerId,
      quizType: quizType ?? this.quizType,
      quizRandomizedSettings: quizRandomizedSettings ?? this.quizRandomizedSettings,
      isPremium: isPremium ?? this.isPremium,
      position: position ?? this.position,
      title: title ?? this.title,
      pinnedAt: pinnedAt ?? this.pinnedAt,
      files: files ?? this.files,
      parentFeedId: parentFeedId ?? this.parentFeedId,
      orderIndex: orderIndex ?? this.orderIndex,
      creatorId: creatorId ?? this.creatorId,
      settings: settings ?? this.settings,
      feed: feed ?? this.feed,
      coachingProgramSubmission: coachingProgramSubmission ?? this.coachingProgramSubmission,
      meta: meta ?? this.meta,
    );
  }

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'] ?? 0,
      programId: json['programId'] ?? 0,
      userId: json['userId'] ?? 0,
      feedType: json['feedType'] ?? '',
      coachingSessionId: json['coachingSessionId'] ?? 0,
      feedData: json['feedData'] ?? '',
      commentCount: json['commentCount'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isNotified: json['isNotified'] ?? 0,
      communityFeedId: json['communityFeedId'] ?? 0,
      studentId: json['studentId'] ?? 0,
      coachingLibraryId: json['coachingLibraryId'] ?? 0,
      liveSchedulerId: json['liveSchedulerId'] ?? 0,
      quizType: json['quizType'] ?? '',
      quizRandomizedSettings: json['quizRandomizedSettings'] ?? '',
      isPremium: json['isPremium'] ?? 0,
      position: json['position'] ?? 0,
      title: json['title'] ?? '',
      pinnedAt: json['pinnedAt'] ?? '',
      files: json['files'] ?? '',
      parentFeedId: json['parentFeedId'] ?? 0,
      orderIndex: json['orderIndex'] ?? 0,
      creatorId: json['creatorId'] ?? 0,
      settings: json['settings'] ?? '',
      feed: json['feed'] != null ? Feed.fromJson(json['feed']) : const Feed(),
      coachingProgramSubmission: json['coachingProgramSubmission'] != null ? (json['coachingProgramSubmission'] as List).map((item) => CoachingProgramSubmission.fromJson(item)).toList() : [],
      meta: json['meta'] != null ? FeedItemMeta.fromJson(json['meta']) : const FeedItemMeta(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'programId': programId,
      'userId': userId,
      'feedType': feedType,
      'coachingSessionId': coachingSessionId,
      'feedData': feedData,
      'commentCount': commentCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isNotified': isNotified,
      'communityFeedId': communityFeedId,
      'studentId': studentId,
      'coachingLibraryId': coachingLibraryId,
      'liveSchedulerId': liveSchedulerId,
      'quizType': quizType,
      'quizRandomizedSettings': quizRandomizedSettings,
      'isPremium': isPremium,
      'position': position,
      'title': title,
      'pinnedAt': pinnedAt,
      'files': files,
      'parentFeedId': parentFeedId,
      'orderIndex': orderIndex,
      'creatorId': creatorId,
      'settings': settings,
      'feed': feed.toJson(),
      'coachingProgramSubmission': coachingProgramSubmission.map((item) => item.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }

  dynamic get parsedFeedData {
    if (feedData.isEmpty) return null;
    try {
      final Map<String, dynamic> decoded = jsonDecode(feedData);
      switch (feedType) {
        case 'Task':
          return FeedDataModel.fromJson(decoded);
        case 'Journal':
          return JournalFeedData.fromJson(decoded);
        default:
          return decoded;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  List<Object?> get props => [
    id,
    programId,
    userId,
    feedType,
    coachingSessionId,
    feedData,
    commentCount,
    createdAt,
    updatedAt,
    isNotified,
    communityFeedId,
    studentId,
    coachingLibraryId,
    liveSchedulerId,
    quizType,
    quizRandomizedSettings,
    isPremium,
    position,
    title,
    pinnedAt,
    files,
    parentFeedId,
    orderIndex,
    creatorId,
    settings,
    feed,
    coachingProgramSubmission,
    meta,
  ];
}

class Feed extends Equatable {
  final int id;
  final int courseId;
  final int lessonId;
  final String activityType;
  final String fileType;
  final String files;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int shareId;
  final String metaData;
  final int coachingFeedId;
  final String feedPrivacy;
  final int groupId;
  final int isAnonymous;
  final Map<String, dynamic> meta;

  const Feed({
    this.id = 0,
    this.courseId = 0,
    this.lessonId = 0,
    this.activityType = '',
    this.fileType = '',
    this.files = '',
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.shareId = 0,
    this.metaData = '',
    this.coachingFeedId = 0,
    this.feedPrivacy = '',
    this.groupId = 0,
    this.isAnonymous = 0,
    this.meta = const {},
  });

  factory Feed.empty() {
    return const Feed();
  }

  Feed copyWith({
    int? id,
    int? courseId,
    int? lessonId,
    String? activityType,
    String? fileType,
    String? files,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    int? shareId,
    String? metaData,
    int? coachingFeedId,
    String? feedPrivacy,
    int? groupId,
    int? isAnonymous,
    Map<String, dynamic>? meta,
  }) {
    return Feed(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      lessonId: lessonId ?? this.lessonId,
      activityType: activityType ?? this.activityType,
      fileType: fileType ?? this.fileType,
      files: files ?? this.files,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      shareId: shareId ?? this.shareId,
      metaData: metaData ?? this.metaData,
      coachingFeedId: coachingFeedId ?? this.coachingFeedId,
      feedPrivacy: feedPrivacy ?? this.feedPrivacy,
      groupId: groupId ?? this.groupId,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      meta: meta ?? this.meta,
    );
  }

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'] ?? 0,
      courseId: json['course_id'] ?? 0,
      lessonId: json['lesson_id'] ?? 0,
      activityType: json['activity_type'] ?? '',
      fileType: json['file_type'] ?? '',
      files: json['files'] ?? '',
      likeCount: json['like_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      shareCount: json['share_count'] ?? 0,
      shareId: json['share_id'] ?? 0,
      metaData: json['meta_data'] ?? '',
      coachingFeedId: json['coaching_feed_id'] ?? 0,
      feedPrivacy: json['feed_privacy'] ?? '',
      groupId: json['group_id'] ?? 0,
      isAnonymous: json['is_anonymous'] ?? 0,
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'lesson_id': lessonId,
      'activity_type': activityType,
      'file_type': fileType,
      'files': files,
      'like_count': likeCount,
      'comment_count': commentCount,
      'share_count': shareCount,
      'share_id': shareId,
      'meta_data': metaData,
      'coaching_feed_id': coachingFeedId,
      'feed_privacy': feedPrivacy,
      'group_id': groupId,
      'is_anonymous': isAnonymous,
      'meta': meta,
    };
  }

  @override
  List<Object?> get props => [
    id,
    courseId,
    lessonId,
    activityType,
    fileType,
    files,
    likeCount,
    commentCount,
    shareCount,
    shareId,
    metaData,
    coachingFeedId,
    feedPrivacy,
    groupId,
    isAnonymous,
    meta,
  ];
}

class CoachingProgramSubmission extends Equatable {
  final int id;
  final int coachingProgramId;
  final String trackingTitle;
  final String type;
  final String label;
  final double value;
  final String durationStart;
  final String answer;
  final String files;
  final String unit;
  final int goal;
  final String goalDurationStart;
  final String trackerSubitemId;
  final int feedId;

  const CoachingProgramSubmission({
    this.id = 0,
    this.coachingProgramId = 0,
    this.trackingTitle = '',
    this.type = '',
    this.label = '',
    this.value = 0.0,
    this.durationStart = '',
    this.answer = '',
    this.files = '',
    this.unit = '',
    this.goal = 0,
    this.goalDurationStart = '',
    this.trackerSubitemId = '',
    this.feedId = 0,
  });

  factory CoachingProgramSubmission.empty() {
    return const CoachingProgramSubmission();
  }

  CoachingProgramSubmission copyWith({
    int? id,
    int? coachingProgramId,
    String? trackingTitle,
    String? type,
    String? label,
    double? value,
    String? durationStart,
    String? answer,
    String? files,
    String? unit,
    int? goal,
    String? goalDurationStart,
    String? trackerSubitemId,
    int? feedId,
  }) {
    return CoachingProgramSubmission(
      id: id ?? this.id,
      coachingProgramId: coachingProgramId ?? this.coachingProgramId,
      trackingTitle: trackingTitle ?? this.trackingTitle,
      type: type ?? this.type,
      label: label ?? this.label,
      value: value ?? this.value,
      durationStart: durationStart ?? this.durationStart,
      answer: answer ?? this.answer,
      files: files ?? this.files,
      unit: unit ?? this.unit,
      goal: goal ?? this.goal,
      goalDurationStart: goalDurationStart ?? this.goalDurationStart,
      trackerSubitemId: trackerSubitemId ?? this.trackerSubitemId,
      feedId: feedId ?? this.feedId,
    );
  }

  factory CoachingProgramSubmission.fromJson(Map<String, dynamic> json) {
    return CoachingProgramSubmission(
      id: json['id'] ?? 0,
      coachingProgramId: json['coachingProgramId'] ?? 0,
      trackingTitle: json['trackingTitle'] ?? '',
      type: json['type'] ?? '',
      label: json['label'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      durationStart: json['durationStart'] ?? '',
      answer: json['answer'] ?? '',
      files: json['files'] ?? '',
      unit: json['unit'] ?? '',
      goal: json['goal'] ?? 0,
      goalDurationStart: json['goalDurationStart'] ?? '',
      trackerSubitemId: json['trackerSubitemId'] ?? '',
      feedId: json['feedId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coachingProgramId': coachingProgramId,
      'trackingTitle': trackingTitle,
      'type': type,
      'label': label,
      'value': value,
      'durationStart': durationStart,
      'answer': answer,
      'files': files,
      'unit': unit,
      'goal': goal,
      'goalDurationStart': goalDurationStart,
      'trackerSubitemId': trackerSubitemId,
      'feedId': feedId,
    };
  }

  @override
  List<Object?> get props => [
    id,
    coachingProgramId,
    trackingTitle,
    type,
    label,
    value,
    durationStart,
    answer,
    files,
    unit,
    goal,
    goalDurationStart,
    trackerSubitemId,
    feedId,
  ];
}

class FeedItemMeta extends Equatable {
  final String startDay;
  final String endDay;
  final String repeatType;
  final String days;
  final String difference;
  final int isWorkout;
  final String descriptionText;
  final int submissionCount;

  const FeedItemMeta({
    this.startDay = '',
    this.endDay = '',
    this.repeatType = '',
    this.days = '',
    this.difference = '',
    this.isWorkout = 0,
    this.descriptionText = '',
    this.submissionCount = 0,
  });

  factory FeedItemMeta.empty() {
    return const FeedItemMeta();
  }

  FeedItemMeta copyWith({
    String? startDay,
    String? endDay,
    String? repeatType,
    String? days,
    String? difference,
    int? isWorkout,
    String? descriptionText,
    int? submissionCount,
  }) {
    return FeedItemMeta(
      startDay: startDay ?? this.startDay,
      endDay: endDay ?? this.endDay,
      repeatType: repeatType ?? this.repeatType,
      days: days ?? this.days,
      difference: difference ?? this.difference,
      isWorkout: isWorkout ?? this.isWorkout,
      descriptionText: descriptionText ?? this.descriptionText,
      submissionCount: submissionCount ?? this.submissionCount,
    );
  }

  factory FeedItemMeta.fromJson(Map<String, dynamic> json) {
    return FeedItemMeta(
      startDay: json['start_day'] ?? '',
      endDay: json['end_day'] ?? '',
      repeatType: json['repeat_type'] ?? '',
      days: json['days'] ?? '',
      difference: json['difference'] ?? '',
      isWorkout: json['is_workout'] ?? 0,
      descriptionText: json['description_text'] ?? '',
      submissionCount: json['submission_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_day': startDay,
      'end_day': endDay,
      'repeat_type': repeatType,
      'days': days,
      'difference': difference,
      'is_workout': isWorkout,
      'description_text': descriptionText,
      'submission_count': submissionCount,
    };
  }

  @override
  List<Object?> get props => [
    startDay,
    endDay,
    repeatType,
    days,
    difference,
    isWorkout,
    descriptionText,
    submissionCount,
  ];
}

class FeedDataModel extends Equatable {
  final TaskExercise taskExercise;
  final Tracker tracker;

  const FeedDataModel({
    this.taskExercise = const TaskExercise(),
    this.tracker = const Tracker(),
  });

  factory FeedDataModel.empty() {
    return const FeedDataModel();
  }

  FeedDataModel copyWith({
    TaskExercise? taskExercise,
    Tracker? tracker,
  }) {
    return FeedDataModel(
      taskExercise: taskExercise ?? this.taskExercise,
      tracker: tracker ?? this.tracker,
    );
  }

  factory FeedDataModel.fromJson(Map<String, dynamic> json) {
    return FeedDataModel(
      taskExercise: json['task_exercise'] != null ? TaskExercise.fromJson(json['task_exercise']) : const TaskExercise(),
      tracker: json['tracker'] != null ? Tracker.fromJson(json['tracker']) : const Tracker(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_exercise': taskExercise.toJson(),
      'tracker': tracker.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    taskExercise,
    tracker,
  ];
}

class TaskExercise extends Equatable {
  final String title;
  final String type;
  final String description;
  final List<UploadFile> uploadFiles;
  final int coachingLibraryId;
  final int categoryId;
  final TaskExerciseSettings settings;
  final int trackerId;

  const TaskExercise({
    this.title = '',
    this.type = '',
    this.description = '',
    this.uploadFiles = const [],
    this.coachingLibraryId = 0,
    this.categoryId = 0,
    this.settings = const TaskExerciseSettings(),
    this.trackerId = 0,
  });

  factory TaskExercise.empty() {
    return const TaskExercise();
  }

  TaskExercise copyWith({
    String? title,
    String? type,
    String? description,
    List<UploadFile>? uploadFiles,
    int? coachingLibraryId,
    int? categoryId,
    TaskExerciseSettings? settings,
    int? trackerId,
  }) {
    return TaskExercise(
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      uploadFiles: uploadFiles ?? this.uploadFiles,
      coachingLibraryId: coachingLibraryId ?? this.coachingLibraryId,
      categoryId: categoryId ?? this.categoryId,
      settings: settings ?? this.settings,
      trackerId: trackerId ?? this.trackerId,
    );
  }

  factory TaskExercise.fromJson(Map<String, dynamic> json) {
    return TaskExercise(
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      uploadFiles: json['upload_files'] != null ? (json['upload_files'] as List).map((item) => UploadFile.fromJson(item)).toList() : [],
      coachingLibraryId: json['coaching_library_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      settings: json['settings'] != null ? TaskExerciseSettings.fromJson(json['settings']) : const TaskExerciseSettings(),
      trackerId: json['tracker_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'upload_files': uploadFiles.map((item) => item.toJson()).toList(),
      'coaching_library_id': coachingLibraryId,
      'category_id': categoryId,
      'settings': settings.toJson(),
      'tracker_id': trackerId,
    };
  }

  @override
  List<Object?> get props => [
    title,
    type,
    description,
    uploadFiles,
    coachingLibraryId,
    categoryId,
    settings,
    trackerId,
  ];
}

class UploadFile extends Equatable {
  final UploadFileMeta meta;
  final String fileType;
  final String originalName;

  const UploadFile({
    this.meta = const UploadFileMeta(),
    this.fileType = '',
    this.originalName = '',
  });

  factory UploadFile.empty() {
    return const UploadFile();
  }

  UploadFile copyWith({
    UploadFileMeta? meta,
    String? fileType,
    String? originalName,
  }) {
    return UploadFile(
      meta: meta ?? this.meta,
      fileType: fileType ?? this.fileType,
      originalName: originalName ?? this.originalName,
    );
  }

  factory UploadFile.fromJson(Map<String, dynamic> json) {
    return UploadFile(
      meta: json['meta'] != null ? UploadFileMeta.fromJson(json['meta']) : const UploadFileMeta(),
      fileType: json['file_type'] ?? '',
      originalName: json['original_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'file_type': fileType,
      'original_name': originalName,
    };
  }

  @override
  List<Object?> get props => [
    meta,
    fileType,
    originalName,
  ];
}

class UploadFileMeta extends Equatable {
  final String fileLink;

  const UploadFileMeta({
    this.fileLink = '',
  });

  factory UploadFileMeta.empty() {
    return const UploadFileMeta();
  }

  UploadFileMeta copyWith({
    String? fileLink,
  }) {
    return UploadFileMeta(
      fileLink: fileLink ?? this.fileLink,
    );
  }

  factory UploadFileMeta.fromJson(Map<String, dynamic> json) {
    return UploadFileMeta(
      fileLink: json['file_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_link': fileLink,
    };
  }

  @override
  List<Object?> get props => [
    fileLink,
  ];
}

class TaskExerciseSettings extends Equatable {
  final List<String> studentFiles;

  const TaskExerciseSettings({
    this.studentFiles = const [],
  });

  factory TaskExerciseSettings.empty() {
    return const TaskExerciseSettings();
  }

  TaskExerciseSettings copyWith({
    List<String>? studentFiles,
  }) {
    return TaskExerciseSettings(
      studentFiles: studentFiles ?? this.studentFiles,
    );
  }

  factory TaskExerciseSettings.fromJson(Map<String, dynamic> json) {
    return TaskExerciseSettings(
      studentFiles: json['student_files'] != null ? List<String>.from(json['student_files']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_files': studentFiles,
    };
  }

  @override
  List<Object?> get props => [
    studentFiles,
  ];
}

class Tracker extends Equatable {
  final String title;
  final List<TrackerInput> inputs;

  const Tracker({
    this.title = '',
    this.inputs = const [],
  });

  factory Tracker.empty() {
    return const Tracker();
  }

  Tracker copyWith({
    String? title,
    List<TrackerInput>? inputs,
  }) {
    return Tracker(
      title: title ?? this.title,
      inputs: inputs ?? this.inputs,
    );
  }

  factory Tracker.fromJson(Map<String, dynamic> json) {
    return Tracker(
      title: json['title'] ?? '',
      inputs: json['inputs'] != null ? (json['inputs'] as List).map((item) => TrackerInput.fromJson(item)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'inputs': inputs.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    title,
    inputs,
  ];
}

class TrackerInput extends Equatable {
  final String trackerSubitemId;
  final String type;
  final String label;
  final int goal;
  final String unit;
  final String startTime;
  final List<String> options;

  const TrackerInput({
    this.trackerSubitemId = '',
    this.type = '',
    this.label = '',
    this.goal = 0,
    this.unit = '',
    this.startTime = '',
    this.options = const [],
  });

  factory TrackerInput.empty() {
    return const TrackerInput();
  }

  TrackerInput copyWith({
    String? trackerSubitemId,
    String? type,
    String? label,
    int? goal,
    String? unit,
    String? startTime,
    List<String>? options,
  }) {
    return TrackerInput(
      trackerSubitemId: trackerSubitemId ?? this.trackerSubitemId,
      type: type ?? this.type,
      label: label ?? this.label,
      goal: goal ?? this.goal,
      unit: unit ?? this.unit,
      startTime: startTime ?? this.startTime,
      options: options ?? this.options,
    );
  }

  factory TrackerInput.fromJson(Map<String, dynamic> json) {
    return TrackerInput(
      trackerSubitemId: json['trackerSubitemId'] ?? '',
      type: json['type'] ?? '',
      label: json['label'] ?? '',
      goal: json['goal'] ?? 0,
      unit: json['unit'] ?? '',
      startTime: json['startTime'] ?? '',
      options: json['options'] != null ? List<String>.from(json['options']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackerSubitemId': trackerSubitemId,
      'type': type,
      'label': label,
      'goal': goal,
      'unit': unit,
      'startTime': startTime,
      'options': options,
    };
  }

  @override
  List<Object?> get props => [
    trackerSubitemId,
    type,
    label,
    goal,
    unit,
    startTime,
    options,
  ];
}

// Journal Feed Data Model
class JournalFeedData extends Equatable {
  final Journal journal;

  const JournalFeedData({
    this.journal = const Journal(),
  });

  factory JournalFeedData.empty() {
    return const JournalFeedData();
  }

  JournalFeedData copyWith({
    Journal? journal,
  }) {
    return JournalFeedData(
      journal: journal ?? this.journal,
    );
  }

  factory JournalFeedData.fromJson(Map<String, dynamic> json) {
    return JournalFeedData(
      journal: json['journal'] != null ? Journal.fromJson(json['journal']) : const Journal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'journal': journal.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    journal,
  ];
}

class Journal extends Equatable {
  final String title;
  final String description;
  final int charLimit;
  final bool allowEdit;

  const Journal({
    this.title = '',
    this.description = '',
    this.charLimit = 0,
    this.allowEdit = false,
  });

  factory Journal.empty() {
    return const Journal();
  }

  Journal copyWith({
    String? title,
    String? description,
    int? charLimit,
    bool? allowEdit,
  }) {
    return Journal(
      title: title ?? this.title,
      description: description ?? this.description,
      charLimit: charLimit ?? this.charLimit,
      allowEdit: allowEdit ?? this.allowEdit,
    );
  }

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      charLimit: json['char_limit'] ?? 0,
      allowEdit: json['allow_edit'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'char_limit': charLimit,
      'allow_edit': allowEdit,
    };
  }

  @override
  List<Object?> get props => [
    title,
    description,
    charLimit,
    allowEdit,
  ];
}
