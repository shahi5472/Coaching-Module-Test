import 'package:coaching_module_test/core/base/widgets/fields/custom_text_form_view.dart';
import 'package:coaching_module_test/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../utils/constansts/color_constants.dart';
import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../../../../utils/manager/extensions/custom_string_extensions.dart';
import '../../../base/services/global_usecases/save_access_token.dart';
import '../../../base/widgets/buttons/primary_button.dart';
import '../../../base/widgets/fields/custom_password_form_view.dart';
import '../services/usecase/login_usecase.dart';
import 'login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenController(
        context: context,
        iNavigator: iNavigator,
        loginUseCase: sl<LoginUseCase>(),
        saveAccessToken: sl<SaveAccessToken>(),
      ),
      child: const _LoginScreenWidget(),
    );
  }
}

class _LoginScreenWidget extends StatelessWidget {
  const _LoginScreenWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        fit: .expand,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: defaultPadding),
              child: Form(
                key: context.read<LoginScreenController>().formKey,
                child: Column(
                  spacing: defaultPadding,
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    const FlutterLogo(size: 200),
                    const SizedBox(),
                    CustomTextFormView(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: context.read<LoginScreenController>().emailEditController,
                      validator: (val) {
                        if (val.isNullOrEmpty) {
                          return "Please enter email address";
                        }
                        if (!ValidationUtils.isEmailValid(val)) {
                          return "Please enter email address";
                        }
                        return null;
                      },
                    ),
                    CustomPasswordFormView(
                      hintText: 'Password',
                      controller: context.read<LoginScreenController>().passwordEditController,
                      validator: (val) {
                        if (val.isNullOrEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                    ),
                    Consumer<LoginScreenController>(
                      builder: (context, controller, _) {
                        return PrimaryButton(
                          title: 'Login',
                          onPressed: () => controller.onSubmit(),
                          isLoading: controller.isLoading,
                          width: double.infinity,
                          foregroundColor: primaryColor,
                          backgroundColor: whiteColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
