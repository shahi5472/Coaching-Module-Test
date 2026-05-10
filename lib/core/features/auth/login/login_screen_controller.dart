import 'package:flutter/cupertino.dart';

import '../../../../routes/app_pages.dart';
import '../../../base/controller/base/base_controller.dart';
import '../../../base/controller/profile_service.dart';
import '../../../base/services/global_usecases/save_access_token.dart';
import '../../../base/services/global_usecases/save_refresh_token.dart';
import '../../../base/services/global_usecases/set_user_info_usecase.dart';
import '../services/data/params/login_request_params.dart';
import '../services/usecase/login_usecase.dart';

class LoginScreenController extends BaseController {
  LoginScreenController({
    required super.context,
    required super.iNavigator,
    required this.loginUseCase,
    required this.saveAccessToken,
    required this.saveRefreshToken,
    required this.setUserInfoUseCase,
    required this.profileService,
  });

  ///Use-Case
  final LoginUseCase loginUseCase;
  final SaveAccessToken saveAccessToken;
  final SaveRefreshToken saveRefreshToken;
  final SetUserInfoUseCase setUserInfoUseCase;
  final ProfileService profileService;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameEditController = TextEditingController(text: 'dev@ignitionit.com');

  @override
  void dispose() {
    userNameEditController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    isLoading = true;
    notifyListeners();

    String userName = userNameEditController.text;
    final LoginRequestParams params = LoginRequestParams(
      username: userName,
      token: "",
    );
    final resultEither = await loginUseCase.call(params);

    resultEither.fold(
      (left) {
        isLoading = false;
        notifyListeners();
        showSnackBar(left.message, isError: true);
      },
      (right) async {
        if (right.success) {
          await saveAccessToken.call(right.data.token);
          // await saveRefreshToken.call(right.data.refreshToken);
          await setUserInfoUseCase.call(right);

          profileService.setUser(right.data.user);
          isLoading = false;
          notifyListeners();

          if (context.mounted) {
            _navigateRoute(Routes.home);
          }
        } else {
          isLoading = false;
          notifyListeners();
          showSnackBar("Login Failed, try again!", isError: true);
        }
      },
    );
  }

  void _navigateRoute(String route) {
    iNavigator.pushReplacementNamed(
      context,
      route,
      analyticKey: route,
    );
  }
}
