import 'package:flutter/material.dart';

class CustomResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const CustomResponsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width <= 767;

  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width >= 768 && MediaQuery.sizeOf(context).width <= 1023;

  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1024;

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1024 then we consider it a desktop
    if (context.isDesktopView) {
      return desktop;
    }
    // If width it less then 768 and more then 1023 we consider it as tablet
    else if (context.isTabletView && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

extension ResponsiveEx on BuildContext {
  bool get isMobileView => CustomResponsive.isMobile(this);

  bool get isTabletView => CustomResponsive.isTablet(this);

  bool get isDesktopView => CustomResponsive.isDesktop(this);
}
