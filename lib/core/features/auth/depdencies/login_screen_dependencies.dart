import 'dart:async';

import '../../../../app/model/base/base_interfaces/i_dependencies.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../../../base/services/global_repository/i_global_repository.dart';
import '../../../base/services/global_usecases/set_user_info_usecase.dart';
import '../services/usecase/login_usecase.dart';

class LoginScreenDependencies extends IDependencies {
  LoginScreenDependencies._();

  static LoginScreenDependencies get instance => LoginScreenDependencies._();

  @override
  FutureOr<void> dependencies() {
    if (!getIt.isRegistered<LoginUseCase>()) {
      getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl<IGlobalRepository>()));
    }
    if (!getIt.isRegistered<SetUserInfoUseCase>()) {
      getIt.registerLazySingleton<SetUserInfoUseCase>(() => SetUserInfoUseCase(iGlobalRepository: sl<IGlobalRepository>()));
    }
  }

  @override
  void dispose() {
    if (getIt.isRegistered<LoginUseCase>()) {
      getIt.unregister<LoginUseCase>();
    }
    if (getIt.isRegistered<SetUserInfoUseCase>()) {
      getIt.unregister<SetUserInfoUseCase>();
    }
  }
}
