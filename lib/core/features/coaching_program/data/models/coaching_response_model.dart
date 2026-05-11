import 'dart:convert';

import 'package:equatable/equatable.dart';

class CoachingListResponseModel extends Equatable {
  final CoachingListMeta meta;
  final List<CoachingItem> data;

  const CoachingListResponseModel({
    this.meta = const CoachingListMeta(),
    this.data = const [],
  });

  factory CoachingListResponseModel.empty() {
    return const CoachingListResponseModel();
  }

  CoachingListResponseModel copyWith({
    CoachingListMeta? meta,
    List<CoachingItem>? data,
  }) {
    return CoachingListResponseModel(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  factory CoachingListResponseModel.fromJson(Map<String, dynamic> json) {
    return CoachingListResponseModel(
      meta: json['meta'] != null ? CoachingListMeta.fromJson(json['meta']) : const CoachingListMeta(),
      data: json['data'] != null ? (json['data'] as List).map((item) => CoachingItem.fromJson(item)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [meta, data];
}

class CoachingListMeta extends Equatable {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String previousPageUrl;

  const CoachingListMeta({
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

  factory CoachingListMeta.empty() {
    return const CoachingListMeta();
  }

  CoachingListMeta copyWith({
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
    return CoachingListMeta(
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

  factory CoachingListMeta.fromJson(Map<String, dynamic> json) {
    return CoachingListMeta(
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page'] ?? 0,
      firstPage: json['first_page'] ?? 0,
      firstPageUrl: json['first_page_url'] ?? '',
      lastPageUrl: json['last_page_url'] ?? '',
      nextPageUrl: json['next_page_url'] ?? '',
      previousPageUrl: json['previous_page_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'per_page': perPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'first_page': firstPage,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'previous_page_url': previousPageUrl,
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

class CoachingItem extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String type;
  final CoachingSettings settings;
  final String thumbnail;
  final String cover;
  final int totalMembers;
  final String status;
  final int coachingProgramId;
  final int enrollmentId;
  final String expiredAt;
  final String expiryDate;

  const CoachingItem({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.type = '',
    this.settings = const CoachingSettings(),
    this.thumbnail = '',
    this.cover = '',
    this.totalMembers = 0,
    this.status = '',
    this.coachingProgramId = 0,
    this.enrollmentId = 0,
    this.expiredAt = '',
    this.expiryDate = '',
  });

  factory CoachingItem.empty() {
    return const CoachingItem();
  }

  CoachingItem copyWith({
    int? id,
    String? title,
    String? slug,
    String? type,
    CoachingSettings? settings,
    String? thumbnail,
    String? cover,
    int? totalMembers,
    String? status,
    int? coachingProgramId,
    int? enrollmentId,
    String? expiredAt,
    String? expiryDate,
  }) {
    return CoachingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      type: type ?? this.type,
      settings: settings ?? this.settings,
      thumbnail: thumbnail ?? this.thumbnail,
      cover: cover ?? this.cover,
      totalMembers: totalMembers ?? this.totalMembers,
      status: status ?? this.status,
      coachingProgramId: coachingProgramId ?? this.coachingProgramId,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      expiredAt: expiredAt ?? this.expiredAt,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  factory CoachingItem.fromJson(Map<String, dynamic> json) {
    return CoachingItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      type: json['type'] ?? '',
      settings: json['settings'] != null ? CoachingSettings.fromJsonString(json['settings']) : const CoachingSettings(),
      thumbnail: json['thumbnail'] ?? '',
      cover: json['cover'] ?? '',
      totalMembers: json['total_members'] ?? 0,
      status: json['status'] ?? '',
      coachingProgramId: json['coaching_program_id'] ?? 0,
      enrollmentId: json['enrollment_id'] ?? 0,
      expiredAt: json['expired_at'] ?? '',
      expiryDate: json['expiry_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'type': type,
      'settings': settings.toJsonString(),
      'thumbnail': thumbnail,
      'cover': cover,
      'total_members': totalMembers,
      'status': status,
      'coaching_program_id': coachingProgramId,
      'enrollment_id': enrollmentId,
      'expired_at': expiredAt,
      'expiry_date': expiryDate,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    type,
    settings,
    thumbnail,
    cover,
    totalMembers,
    status,
    coachingProgramId,
    enrollmentId,
    expiredAt,
    expiryDate,
  ];
}

class CoachingSettings extends Equatable {
  final String timeZone;
  final String weekBased;
  final String submissionVisibility;
  final bool habitTab;
  final String dripType;
  final bool allowSubmissionOnPreviousSessions;

  const CoachingSettings({
    this.timeZone = '',
    this.weekBased = '',
    this.submissionVisibility = '',
    this.habitTab = false,
    this.dripType = '',
    this.allowSubmissionOnPreviousSessions = false,
  });

  factory CoachingSettings.empty() {
    return const CoachingSettings();
  }

  CoachingSettings copyWith({
    String? timeZone,
    String? weekBased,
    String? submissionVisibility,
    bool? habitTab,
    String? dripType,
    bool? allowSubmissionOnPreviousSessions,
  }) {
    return CoachingSettings(
      timeZone: timeZone ?? this.timeZone,
      weekBased: weekBased ?? this.weekBased,
      submissionVisibility: submissionVisibility ?? this.submissionVisibility,
      habitTab: habitTab ?? this.habitTab,
      dripType: dripType ?? this.dripType,
      allowSubmissionOnPreviousSessions: allowSubmissionOnPreviousSessions ?? this.allowSubmissionOnPreviousSessions,
    );
  }

  factory CoachingSettings.fromJson(Map<String, dynamic> json) {
    return CoachingSettings(
      timeZone: json['time_zone'] ?? '',
      weekBased: json['week_based'] ?? '',
      submissionVisibility: json['submission_visibility'] ?? '',
      habitTab: json['habit_tab'] ?? false,
      dripType: json['drip_type'] ?? '',
      allowSubmissionOnPreviousSessions: json['allow_submission_on_previous_sessions'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_zone': timeZone,
      'week_based': weekBased,
      'submission_visibility': submissionVisibility,
      'habit_tab': habitTab,
      'drip_type': dripType,
      'allow_submission_on_previous_sessions': allowSubmissionOnPreviousSessions,
    };
  }

  factory CoachingSettings.fromJsonString(String jsonString) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(jsonString);
      return CoachingSettings.fromJson(decoded);
    } catch (e) {
      return const CoachingSettings();
    }
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  List<Object?> get props => [
    timeZone,
    weekBased,
    submissionVisibility,
    habitTab,
    dripType,
    allowSubmissionOnPreviousSessions,
  ];
}
