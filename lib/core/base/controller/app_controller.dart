import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../app/model/base/base_interfaces/i_usecase.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/constansts/color_constants.dart';
import '../services/global_usecases/clear_user_access_tokens.dart';
import '../widgets/loader/full_screen_circle_loader.dart';
import 'base/base_controller.dart';

class AppController extends BaseController {
  AppController({
    required super.context,
    required super.iNavigator,
    required this.clearUserAccessTokensUseCase,
  });

  ///Use-case
  final ClearUserAccessTokensUseCase clearUserAccessTokensUseCase;

  Future<void> logout({required BuildContext context}) async {
    AppUtils.fullScreenDialog(
      context: context,
      child: const FullScreenCircleLoader(circleColor: whiteColor),
    );
    await clearUserAccessTokensUseCase.call(NoParams());
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      if (context.canPop()) {
        context.pop();
      }
      iNavigator.pushReplacementNamed(
        context,
        Routes.login,
        analyticKey: Routes.login,
      );
    }
  }
}
