import '../../../base/controller/base/base_controller.dart';
import '../data/models/coaching_details_response_model.dart';
import '../data/models/coaching_response_model.dart';
import '../data/models/get_feed__list_response_model.dart';
import '../data/models/params/get_coaching_details_request_params.dart';
import '../data/models/params/get_coaching_feed_list_request_params.dart';
import '../data/usecase/get_coaching_details_usecase.dart';
import '../data/usecase/get_feed_list_usecase.dart';

enum CoachingDetailsStatus {
  loading,
  success,
  failed,
  none,
}

class CoachingDetailsState {
  final CoachingItem oldData;
  final CoachingDetailsStatus status;
  final String message;

  final CoachingDetails coachingDetails;

  final List<Session> sessions;

  final GetFeedListResponseModel feedData;

  final CurrentSession? currentSession;

  const CoachingDetailsState({
    required this.oldData,
    required this.status,
    required this.message,
    required this.coachingDetails,
    required this.sessions,
    required this.feedData,
    required this.currentSession,
  });

  factory CoachingDetailsState.initial() {
    return const CoachingDetailsState(
      oldData: CoachingItem(),
      status: CoachingDetailsStatus.none,
      message: '',
      coachingDetails: CoachingDetails(),
      sessions: [],
      feedData: GetFeedListResponseModel(),
      currentSession: null,
    );
  }

  CoachingDetailsState copyWith({
    CoachingItem? oldData,
    CoachingDetailsStatus? status,
    String? message,
    CoachingDetails? coachingDetails,
    List<Session>? sessions,
    GetFeedListResponseModel? feedData,
    CurrentSession? currentSession,
  }) {
    return CoachingDetailsState(
      oldData: oldData ?? this.oldData,
      status: status ?? this.status,
      message: message ?? this.message,
      coachingDetails: coachingDetails ?? this.coachingDetails,
      sessions: sessions ?? this.sessions,
      feedData: feedData ?? this.feedData,
      currentSession: currentSession ?? this.currentSession,
    );
  }
}

class CoachingProgramDetailsScreenController extends BaseController {
  CoachingProgramDetailsScreenController({
    required super.context,
    required super.iNavigator,
    required GetCoachingDetailsUseCase coachingDetailsUseCase,
    required GetFeedListUseCase coachingFeedListUseCase,
  }) : _coachingDetailsUseCase = coachingDetailsUseCase,
       _coachingFeedListUseCase = coachingFeedListUseCase;

  final GetCoachingDetailsUseCase _coachingDetailsUseCase;

  final GetFeedListUseCase _coachingFeedListUseCase;

  CoachingDetailsState state = CoachingDetailsState.initial();

  bool get _apiCalled => state.status == CoachingDetailsStatus.loading;

  Future<void> onRetry() async {
    await fetchCoachingDetails(state.oldData);
  }

  Future<void> fetchCoachingDetails(
    CoachingItem item,
  ) async {
    if (_apiCalled) return;

    state = state.copyWith(
      status: CoachingDetailsStatus.loading,
      oldData: item,
      message: '',
    );

    notifyListeners();

    final result = await _coachingDetailsUseCase.call(
      GetCoachingDetailsRequestParams(
        programId: item.coachingProgramId,
        timeZone: item.settings.timeZone,
      ),
    );

    await result.fold(
      (failure) async {
        state = state.copyWith(
          status: CoachingDetailsStatus.failed,
          message: failure.message,
        );

        notifyListeners();
      },
      (response) async {
        final coachingDetails = response.coachingDetails;

        final sessions = response.sessions;

        final currentSession = _findCurrentSession(sessions: sessions);

        GetFeedListResponseModel feedData = const GetFeedListResponseModel();

        if (currentSession != null) {
          final feedResult = await _coachingFeedListUseCase.call(
            GetCoachingFeedListRequestParams(
              programId: item.id,
              sessionId: 93756,
            ),
          );

          feedResult.fold(
            (failure) {},
            (feedResponse) {
              feedData = feedResponse;
            },
          );
        }

        state = state.copyWith(
          status: CoachingDetailsStatus.success,
          coachingDetails: coachingDetails,
          sessions: sessions,
          currentSession: currentSession,
          feedData: feedData,
          message: '',
        );

        notifyListeners();
      },
    );
  }

  Future<void> onSessionChange(Session session) async {
    final currentSession = CurrentSession(
      currentSessionId: session.id,
      currentSessionParentId: session.parentId,
    );

    state = state.copyWith(
      status: CoachingDetailsStatus.loading,
      currentSession: currentSession,
    );

    notifyListeners();

    final result = await _coachingFeedListUseCase.call(
      GetCoachingFeedListRequestParams(
        programId: state.coachingDetails.id,
        sessionId: session.id,
      ),
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CoachingDetailsStatus.failed,
          message: failure.message,
        );
      },
      (response) {
        state = state.copyWith(
          status: CoachingDetailsStatus.success,
          feedData: response,
          message: '',
        );
      },
    );

    notifyListeners();
  }

  CurrentSession? _findCurrentSession({required List<Session> sessions}) {
    if (sessions.isEmpty) return null;

    try {
      final current = sessions.firstWhere(
        (e) => e.isCurrent == 1,
      );

      return CurrentSession(
        currentSessionId: current.id,
        currentSessionParentId: current.parentId,
      );
    } catch (_) {}

    final first = sessions.first;

    return CurrentSession(
      currentSessionId: first.id,
      currentSessionParentId: first.parentId,
    );
  }

  bool isSelectedSession(Session session) {
    return state.currentSession?.currentSessionId == session.id;
  }

  List<Session> get parentSessions {
    return state.sessions.where((e) => e.parentId == 0).toList();
  }

  List<Session> getSubSessions(int parentId) {
    return state.sessions.where((e) => e.parentId == parentId).toList();
  }

  bool hasSubSession(int parentId) {
    return getSubSessions(parentId).isNotEmpty;
  }
}
