import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/navigator.dart';
import '../../../../utils/app_utils.dart';
import 'lifecycle_state_viewmodel.dart';

abstract class BaseController extends LifeCycleStateViewModel {
  final INavigator iNavigator;
  final BuildContext context;

  BaseController({
    required this.context,
    required this.iNavigator,
  });

  void logAnalyticEvent(String analyticKey, Map<String, String>? parameters) {
    iNavigator.analyticEventLog(analyticKey: analyticKey, params: parameters);
  }

  void showSnackBar(String message, {bool isError = false, String? title}) {
    AppUtils.showSnackBar(context, isError, message, title: title);
  }

  void goBack() => context.pop();
}
