import 'dart:async';

import 'package:coaching_module_test/app/network/dio_wrapper.dart';

import '../../../../../app/model/base/base_interfaces/i_dependencies.dart';
import '../../../../../utils/dependency_injection/custom_getit.dart';
import '../../data/datasource/coaching_program_datasource_impl.dart';
import '../../data/datasource/i_coaching_program_datasource.dart';
import '../../data/repository/coaching_program_repository_impl.dart';
import '../../data/repository/i_coaching_program_repository.dart';
import '../../data/usecase/coaching_list_usecase.dart';

class CoachingProgramListScreenDependencies extends IDependencies {
  CoachingProgramListScreenDependencies._();

  static CoachingProgramListScreenDependencies get instance => CoachingProgramListScreenDependencies._();

  @override
  FutureOr<void> dependencies() {
    if (!getIt.isRegistered<ICoachingProgramDataSource>()) {
      getIt.registerLazySingleton<ICoachingProgramDataSource>(() => CoachingProgramDataSourceImpl(dio: sl<IDioWrapper>()));
    }
    if (!getIt.isRegistered<ICoachingProgramRepository>()) {
      getIt.registerLazySingleton<ICoachingProgramRepository>(() => CoachingProgramRepositoryImpl(dataSource: sl<ICoachingProgramDataSource>()));
    }
    if (!getIt.isRegistered<CoachingListUseCase>()) {
      getIt.registerLazySingleton<CoachingListUseCase>(() => CoachingListUseCase(coachingProgramRepository: sl<ICoachingProgramRepository>()));
    }
  }

  @override
  void dispose() {
    if (getIt.isRegistered<ICoachingProgramDataSource>()) {
      getIt.unregister<ICoachingProgramDataSource>();
    }
    if (getIt.isRegistered<ICoachingProgramRepository>()) {
      getIt.unregister<ICoachingProgramRepository>();
    }
    if (getIt.isRegistered<CoachingListUseCase>()) {
      getIt.unregister<CoachingListUseCase>();
    }
  }
}
