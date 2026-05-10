import 'package:coaching_module_test/utils/dependency_injection/injection.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app/config/globals.dart';
import 'core/base/controller/app_controller.dart';
import 'core/base/controller/profile_service.dart';
import 'core/base/services/global_usecases/clear_user_access_tokens.dart';
import 'flavors.dart';
import 'utils/dependency_injection/custom_getit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.prod,
  );

  await dotenv.load(fileName: F.dotEnvPath);

  await initDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChannels.textInput.invokeMethod('TextInput.hide');

  /// disable logging in the release mode
  if (F.isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  final Widget app = MultiProvider(
    providers: [
      ChangeNotifierProvider<AppController>(
        lazy: false,
        create: (context) => AppController(
          context: context,
          iNavigator: iNavigator,
          clearUserAccessTokensUseCase: sl<ClearUserAccessTokensUseCase>(),
        ),
      ),
      ChangeNotifierProvider<ProfileService>(create: (_) => ProfileService()),
    ],
    child: const App(),
  );

  runApp(
    F.isProduction
        ? app
        : DevicePreview(
            enabled: false,
            builder: (context) => OverlaySupport.global(child: app),
          ),
  );
}
