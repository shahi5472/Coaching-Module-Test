import 'package:coaching_module_test/core/base/controller/base/base_controller.dart';

import '../data/models/coaching_note_response_model.dart';
import '../data/models/params/coaching_note_request_params.dart';
import '../data/usecase/get_coaching_note_usecase.dart';

enum CoachingNoteStatus { loading, success, failed, none }

class CoachingNoteState {
  final int coachingProgramId;
  final int page;
  final List<CoachingNote> items;
  final CoachingNoteStatus status;
  final String message;

  const CoachingNoteState({
    required this.coachingProgramId,
    required this.page,
    required this.items,
    required this.status,
    required this.message,
  });

  factory CoachingNoteState.initial() => const CoachingNoteState(
    coachingProgramId: 0,
    page: 1,
    items: [],
    status: CoachingNoteStatus.none,
    message: '',
  );

  CoachingNoteState copyWith({
    int? coachingProgramId,
    int? page,
    List<CoachingNote>? items,
    CoachingNoteStatus? status,
    String? message,
  }) => CoachingNoteState(
    coachingProgramId: coachingProgramId ?? this.coachingProgramId,
    page: page ?? this.page,
    items: items ?? this.items,
    status: status ?? this.status,
    message: message ?? this.message,
  );
}

class NoteBottomSheetController extends BaseController {
  NoteBottomSheetController({
    required super.context,
    required super.iNavigator,
    required GetCoachingNoteUseCase getCoachingNoteUseCase,
  }) : _coachingNoteUseCase = getCoachingNoteUseCase;

  final GetCoachingNoteUseCase _coachingNoteUseCase;

  CoachingNoteState state = CoachingNoteState.initial();

  Future<void> fetchCoachingNote({required int coachingProgramId}) async {
    if (state.status == CoachingNoteStatus.loading) return;

    state = state.copyWith(status: CoachingNoteStatus.loading, coachingProgramId: coachingProgramId);
    notifyListeners();

    final result = await _coachingNoteUseCase.call(CoachingNoteRequestParams(coachingProgramId: coachingProgramId));

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CoachingNoteStatus.failed,
          message: failure.message,
        );
      },
      (response) {
        state = state.copyWith(
          status: CoachingNoteStatus.success,
          items: [...state.items, ...response.data],
          page: state.page + 1,
          message: '',
        );
      },
    );

    notifyListeners();
  }

  void onRetry() async {
    final id = state.coachingProgramId;
    state = CoachingNoteState.initial().copyWith(coachingProgramId: id);
    notifyListeners();
    fetchCoachingNote(coachingProgramId: id);
  }
}
