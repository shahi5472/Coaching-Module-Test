import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../core/features/auth/depdencies/login_screen_dependencies.dart';
import '../core/features/auth/login/login_screen.dart';
import '../utils/constansts/global.dart';
import 'go_route_wrapper.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = GoRouter(
    initialLocation: _Paths.login,
    navigatorKey: navigatorKey,
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
    ],
    debugLogDiagnostics: kDebugMode,
  );
}
