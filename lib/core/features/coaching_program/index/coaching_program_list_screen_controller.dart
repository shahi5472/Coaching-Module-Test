import 'package:flutter/widgets.dart';

import '../../../base/controller/base/base_controller.dart';
import '../data/models/coaching_response_model.dart';
import '../data/models/params/coaching_list_request_params.dart';
import '../data/usecase/coaching_list_usecase.dart';

enum CoachingListStatus { loading, loadingMore, success, failed, none }

class CoachingListState {
  final int page;
  final List<CoachingItem> items;
  final CoachingListStatus status;
  final String message;
  final bool hasMore;

  const CoachingListState({
    required this.page,
    required this.items,
    required this.status,
    required this.message,
    required this.hasMore,
  });

  factory CoachingListState.initial() => const CoachingListState(
    page: 1,
    items: [],
    status: CoachingListStatus.none,
    message: '',
    hasMore: false,
  );

  CoachingListState copyWith({
    int? page,
    List<CoachingItem>? items,
    CoachingListStatus? status,
    String? message,
    bool? hasMore,
  }) => CoachingListState(
    page: page ?? this.page,
    items: items ?? this.items,
    status: status ?? this.status,
    message: message ?? this.message,
    hasMore: hasMore ?? this.hasMore,
  );
}

class CoachingProgramListScreenController extends BaseController {
  CoachingProgramListScreenController({
    required super.context,
    required super.iNavigator,
    required CoachingListUseCase coachingListUseCase,
  }) : _coachingUseCase = coachingListUseCase;

  final CoachingListUseCase _coachingUseCase;
  final ScrollController scrollController = ScrollController();

  CoachingListState state = CoachingListState.initial();

  bool get _apiCalled => (state.status == CoachingListStatus.loading || state.status == CoachingListStatus.loadingMore);

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    _fetchCoachingList();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final pos = scrollController.position;
    final nearBottom = pos.pixels >= pos.maxScrollExtent - 200;

    if (nearBottom && state.hasMore && !_apiCalled) {
      _fetchCoachingList();
    }
  }

  Future<void> onRefresh() async {
    state = CoachingListState.initial();
    notifyListeners();
    await _fetchCoachingList();
  }

  Future<void> _fetchCoachingList() async {
    if (_apiCalled) return;

    final isFirstPage = state.page == 1;

    state = state.copyWith(status: isFirstPage ? CoachingListStatus.loading : CoachingListStatus.loadingMore);
    notifyListeners();

    final result = await _coachingUseCase.call(CoachingListRequestParams(page: state.page));

    result.fold(
      (failure) {
        state = state.copyWith(
          status: CoachingListStatus.failed,
          message: failure.message,
        );
      },
      (response) {
        state = state.copyWith(
          status: CoachingListStatus.success,
          items: [...state.items, ...response.data],
          page: state.page + 1,
          hasMore: response.meta.nextPageUrl.isNotEmpty,
          message: '',
        );
      },
    );

    notifyListeners();
  }
}
