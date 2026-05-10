import 'package:coaching_module_test/utils/manager/extensions/custom_string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../routes/app_pages.dart';
import '../../../base/controller/base/base_controller.dart';
import '../../../base/services/global_usecases/save_access_token.dart';
import '../services/data/params/login_request_params.dart';
import '../services/usecase/login_usecase.dart';

class LoginScreenController extends BaseController {
  LoginScreenController({
    required super.context,
    required super.iNavigator,
    required this.loginUseCase,
    required this.saveAccessToken,
  });

  ///Use-Case
  final LoginUseCase loginUseCase;
  final SaveAccessToken saveAccessToken;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailEditController = TextEditingController(text: kDebugMode ? "fluttertester@appifylab.com" : null);
  final TextEditingController passwordEditController = TextEditingController(text: kDebugMode ? "123456@@" : null);

  @override
  void dispose() {
    emailEditController.dispose();
    passwordEditController.dispose();
    super.dispose();
  }

  bool isLoading = false;

  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    isLoading = true;
    notifyListeners();

    String email = emailEditController.text;
    String password = passwordEditController.text;
    final LoginRequestParams params = LoginRequestParams(
      email: email,
      password: password,
    );
    final resultEither = await loginUseCase.call(params);

    resultEither.fold(
      (left) {
        isLoading = false;
        notifyListeners();
        showSnackBar(left.message, isError: true);
      },
      (right) async {
        if (right.token.isNullOrEmpty) {
          await saveAccessToken.call(right.token);
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
