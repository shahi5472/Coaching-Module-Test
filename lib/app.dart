import 'dart:ui';

import 'package:coaching_module_test/routes/app_pages.dart';
import 'package:coaching_module_test/utils/constansts/global.dart';
import 'package:coaching_module_test/utils/constansts/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: F.title,
        theme: AppTheme.getTheme(ThemeMode.light),
        darkTheme: AppTheme.getTheme(ThemeMode.dark),
        themeMode: AppTheme.getThemeMode(ThemeMode.light),
        routerConfig: AppPages.routes,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}

/// A custom scroll behavior that supports dragging with multiple input devices
/// and allows customization of scroll physics.
///
/// Useful for multi-platform apps (mobile, desktop, web) to ensure consistent
/// scrolling experience across different input types.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  // Allow drag/scroll gestures using the following pointer device kinds
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch, // Touch input (e.g., phones, tablets)
    PointerDeviceKind.mouse, // Mouse input (e.g., desktop browsers)
    PointerDeviceKind.trackpad, // Trackpad (e.g., macOS devices)
    PointerDeviceKind.stylus, // Stylus or pen input
    PointerDeviceKind.unknown, // Fallback for any unknown device
  };

  @override
  // Provide custom scroll physics (e.g., BouncingScrollPhysics or ClampingScrollPhysics)
  ScrollPhysics getScrollPhysics(BuildContext context) => scrollPhysics;
}
