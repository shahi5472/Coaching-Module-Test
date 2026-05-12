import 'package:equatable/equatable.dart';

class CoachingNoteResponseModel extends Equatable {
  final Meta meta;
  final List<CoachingNote> data;

  const CoachingNoteResponseModel({
    required this.meta,
    required this.data,
  });

  factory CoachingNoteResponseModel.fromJson(Map<String, dynamic> json) {
    return CoachingNoteResponseModel(
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: json['data'] != null ? List<CoachingNote>.from(json['data'].map((x) => CoachingNote.fromJson(x))) : [],
    );
  }

  factory CoachingNoteResponseModel.empty() {
    return CoachingNoteResponseModel(
      meta: Meta.empty(),
      data: const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meta': meta.toJson(),
      'data': data.map((x) => x.toJson()).toList(),
    };
  }

  CoachingNoteResponseModel copyWith({
    Meta? meta,
    List<CoachingNote>? data,
  }) {
    return CoachingNoteResponseModel(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [meta, data];
}

class Meta extends Equatable {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String previousPageUrl;

  const Meta({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.firstPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.previousPageUrl,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 10,
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      firstPage: json['first_page'] ?? 1,
      firstPageUrl: json['first_page_url'] ?? '',
      lastPageUrl: json['last_page_url'] ?? '',
      nextPageUrl: json['next_page_url'] ?? '',
      previousPageUrl: json['previous_page_url'] ?? '',
    );
  }

  factory Meta.empty() {
    return const Meta(
      total: 0,
      perPage: 10,
      currentPage: 1,
      lastPage: 1,
      firstPage: 1,
      firstPageUrl: '',
      lastPageUrl: '',
      nextPageUrl: '',
      previousPageUrl: '',
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

  Meta copyWith({
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
    return Meta(
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

class CoachingNote extends Equatable {
  final int id;
  final String note;
  final int coachingProgramId;
  final String createdAt;
  final String updatedAt;
  final int isViewAllowed;
  final String title;

  const CoachingNote({
    required this.id,
    required this.note,
    required this.coachingProgramId,
    required this.createdAt,
    required this.updatedAt,
    required this.isViewAllowed,
    required this.title,
  });

  factory CoachingNote.fromJson(Map<String, dynamic> json) {
    return CoachingNote(
      id: json['id'] ?? 0,
      note: json['note'] ?? '',
      coachingProgramId: json['coaching_program_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isViewAllowed: json['is_view_allowed'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  factory CoachingNote.empty() {
    return const CoachingNote(
      id: 0,
      note: '',
      coachingProgramId: 0,
      createdAt: '',
      updatedAt: '',
      isViewAllowed: 0,
      title: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'coaching_program_id': coachingProgramId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_view_allowed': isViewAllowed,
      'title': title,
    };
  }

  CoachingNote copyWith({
    int? id,
    String? note,
    int? coachingProgramId,
    String? createdAt,
    String? updatedAt,
    int? isViewAllowed,
    String? title,
  }) {
    return CoachingNote(
      id: id ?? this.id,
      note: note ?? this.note,
      coachingProgramId: coachingProgramId ?? this.coachingProgramId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isViewAllowed: isViewAllowed ?? this.isViewAllowed,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
    id,
    note,
    coachingProgramId,
    createdAt,
    updatedAt,
    isViewAllowed,
    title,
  ];
}
