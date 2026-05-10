import 'package:flutter/material.dart';

extension FontUtilsEx on BuildContext {
  ///=======================Text Theme [Start]==============================

  ///Font-Size: 22 => Font Weight: FontWeight.w400
  TextStyle? get titleLarge => TextTheme.of(this).titleLarge;

  ///Font-Size: 16 => Font Weight: FontWeight.w500
  TextStyle? get titleMedium => TextTheme.of(this).titleMedium;

  ///Font-Size: 14 => Font Weight: FontWeight.w500
  TextStyle? get titleSmall => TextTheme.of(this).titleSmall;

  ///Font-Size: 16 => Font Weight: FontWeight.w400
  TextStyle? get bodyLarge => TextTheme.of(this).bodyLarge;

  ///Font-Size: 14 => Font Weight: FontWeight.w400
  TextStyle? get bodyMedium => TextTheme.of(this).bodyMedium;

  ///Font-Size: 12 => Font Weight: FontWeight.w400
  TextStyle? get bodySmall => TextTheme.of(this).bodySmall;

  ///Font-Size: 14 => Font Weight: FontWeight.w500
  TextStyle? get labelLarge => TextTheme.of(this).labelLarge;

  ///Font-Size: 12 => Font Weight: FontWeight.w500
  TextStyle? get labelMedium => TextTheme.of(this).labelMedium;

  ///Font-Size: 11 => Font Weight: FontWeight.w500
  TextStyle? get labelSmall => TextTheme.of(this).labelSmall;

  ///Font-Size: 57 => Font Weight: FontWeight.w400
  TextStyle? get displayLarge => TextTheme.of(this).displayLarge;

  ///Font-Size: 45 => Font Weight: FontWeight.w400
  TextStyle? get displayMedium => TextTheme.of(this).displayMedium;

  ///Font-Size: 36 => Font Weight: FontWeight.w400
  TextStyle? get displaySmall => TextTheme.of(this).displaySmall;

  ///Font-Size: 32 => Font Weight: FontWeight.w400
  TextStyle? get headlineLarge => TextTheme.of(this).headlineLarge;

  ///Font-Size: 28 => Font Weight: FontWeight.w400
  TextStyle? get headlineMedium => TextTheme.of(this).headlineMedium;

  ///Font-Size: 24 => Font Weight: FontWeight.w400
  TextStyle? get headlineSmall => TextTheme.of(this).headlineSmall;

  ///=======================Text Theme [END]==============================
}
