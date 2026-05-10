import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../app/model/base/base_interfaces/i_usecase.dart';
import '../core/base/services/global_usecases/user_loggedin.dart';
import '../core/features/auth/depdencies/login_screen_dependencies.dart';
import '../core/features/auth/login/login_screen.dart';
import '../core/features/coaching_program/index/coaching_program_list_screen.dart';
import '../core/features/coaching_program/index/dependencies/coaching_program_list_screen_dependencies.dart';
import '../utils/constansts/global.dart';
import '../utils/dependency_injection/custom_getit.dart';
import 'go_route_wrapper.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = GoRouter(
    initialLocation: _Paths.login,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) async {
      final resultEither = await sl<UserLoggedInUseCase>().call(NoParams());

      final isLoggedIn = resultEither.isRight() && resultEither.getOrElse(() => false);

      final isLoginRoute = state.matchedLocation == _Paths.login;

      if (!isLoggedIn && !isLoginRoute) {
        return _Paths.login;
      }

      if (isLoggedIn && isLoginRoute) {
        return _Paths.home;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: _Paths.login,
        name: _Paths.login,
        builder: (context, state) => GoRouteWrapper(
          routeName: _Paths.login,
          iDependencies: LoginScreenDependencies.instance,
          child: const LoginScreen(),
        ),
      ),

      GoRoute(
        path: _Paths.home,
        name: _Paths.home,
        builder: (context, state) => GoRouteWrapper(
          routeName: _Paths.home,
          iDependencies: CoachingProgramListScreenDependencies.instance,
          child: const CoachingProgramListScreen(),
        ),
      ),
    ],
  );
}
