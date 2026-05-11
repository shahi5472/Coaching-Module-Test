import 'dart:async';

import '../../../../../app/model/base/base_interfaces/i_dependencies.dart';
import '../../../../../utils/dependency_injection/custom_getit.dart';
import '../../data/repository/i_coaching_program_repository.dart';
import '../../data/usecase/get_coaching_details_usecase.dart';
import '../../data/usecase/get_feed_list_usecase.dart';

class CoachingProgramDetailsScreenDependencies extends IDependencies {
  CoachingProgramDetailsScreenDependencies._();

  static CoachingProgramDetailsScreenDependencies get instance => CoachingProgramDetailsScreenDependencies._();

  @override
  FutureOr<void> dependencies() {
    if (!getIt.isRegistered<GetCoachingDetailsUseCase>()) {
      getIt.registerLazySingleton<GetCoachingDetailsUseCase>(() => GetCoachingDetailsUseCase(coachingProgramRepository: sl<ICoachingProgramRepository>()));
    }
    if (!getIt.isRegistered<GetFeedListUseCase>()) {
      getIt.registerLazySingleton<GetFeedListUseCase>(() => GetFeedListUseCase(coachingProgramRepository: sl<ICoachingProgramRepository>()));
    }
  }

  @override
  void dispose() {
    if (getIt.isRegistered<GetCoachingDetailsUseCase>()) {
      getIt.unregister<GetCoachingDetailsUseCase>();
    }
    if (getIt.isRegistered<GetFeedListUseCase>()) {
      getIt.unregister<GetFeedListUseCase>();
    }
  }
}
