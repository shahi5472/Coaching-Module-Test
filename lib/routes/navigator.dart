import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract class INavigator {
  Future<T?>? pushNamed<T>(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  });

  Future<void> goNamed(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  });

  Future<void> go(
    BuildContext context,
    String route, {
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  });

  void pop<T>(BuildContext context, {T? result});

  void pushReplacementNamed<T extends Object?>(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    T? arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  });

  void analyticEventLog({required String analyticKey, Map<String, dynamic>? params});
}

class NavigatorImpl extends INavigator {
  NavigatorImpl();

  @override
  void pop<T>(BuildContext context, {T? result}) {
    context.pop(result);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  }) async {
    analyticEventLog(analyticKey: analyticKey, params: analyticsParams);
    return context.pushNamed<T>(
      route,
      queryParameters: queryParameters ?? {},
      pathParameters: pathParameters ?? {},
      extra: arguments,
    );
  }

  @override
  Future<void> goNamed(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  }) async {
    analyticEventLog(analyticKey: analyticKey, params: analyticsParams);
    return context.goNamed(
      route,
      queryParameters: queryParameters ?? {},
      pathParameters: pathParameters ?? {},
      extra: arguments,
    );
  }

  @override
  Future<void> go(
    BuildContext context,
    String route, {
    dynamic arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  }) async {
    analyticEventLog(analyticKey: analyticKey, params: analyticsParams);
    return context.go(
      route,
      extra: arguments,
    );
  }

  @override
  void pushReplacementNamed<T extends Object?>(
    BuildContext context,
    String route, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParameters,
    T? arguments,
    required String analyticKey,
    Map<String, dynamic>? analyticsParams,
  }) {
    analyticEventLog(analyticKey: analyticKey, params: analyticsParams);
    context.pushReplacementNamed(
      route,
      queryParameters: queryParameters ?? {},
      pathParameters: pathParameters ?? {},
      extra: arguments,
    );
  }

  @override
  void analyticEventLog({required String analyticKey, Map<String, dynamic>? params}) {}
}
