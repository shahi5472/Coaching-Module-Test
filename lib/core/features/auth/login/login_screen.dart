import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../utils/constansts/color_constants.dart';
import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../../../../utils/manager/extensions/custom_string_extensions.dart';
import '../../../base/controller/profile_service.dart';
import '../../../base/services/global_usecases/save_access_token.dart';
import '../../../base/services/global_usecases/save_refresh_token.dart';
import '../../../base/services/global_usecases/set_user_info_usecase.dart';
import '../../../base/widgets/buttons/primary_button.dart';
import '../../../base/widgets/fields/custom_password_form_view.dart';
import '../../../base/widgets/image/custom_image_view.dart';
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
        saveRefreshToken: sl<SaveRefreshToken>(),
        setUserInfoUseCase: sl<SetUserInfoUseCase>(),
        profileService: context.read<ProfileService>(),
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
      body: Stack(
        clipBehavior: Clip.none,
        fit: .expand,
        children: [
          const Positioned.fill(
            child: CustomImageView(
              path: 'assets/images/onboard.svg',
              fit: BoxFit.cover,
            ),
          ),
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
                    const CustomImageView(
                      width: 250,
                      height: 110,
                      path: 'assets/logo/logo.png',
                    ),
                    const SizedBox(),
                    CustomPasswordFormView(
                      hintText: 'Username',
                      controller: context.read<LoginScreenController>().userNameEditController,
                      validator: (val) {
                        if (val.isNullOrEmpty) {
                          return "Please enter username";
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
