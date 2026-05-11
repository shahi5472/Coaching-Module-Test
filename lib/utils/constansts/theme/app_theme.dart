import 'package:flutter/material.dart';

import '../color_constants.dart';
import '../dimentions.dart';
import '../font_utils/font_utils.dart';

class AppTheme {
  AppTheme._();

  static ThemeMode getThemeMode(ThemeMode selectedTheme) {
    if (ThemeMode.dark == selectedTheme) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  static ThemeData getTheme(ThemeMode selectedTheme) {
    switch (selectedTheme) {
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.dark:
        return _darkTheme;
      case ThemeMode.system:
        return _lightTheme;
    }
  }

  static ThemeData get _lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: const TextTheme()
          .apply(
            fontFamily: FontUtils.primaryFont,
            bodyColor: titleTextColor,
            displayColor: titleTextColor,
          )
          .copyWith(
            bodyLarge: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            bodyMedium: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            bodySmall: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            displayLarge: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            displayMedium: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            displaySmall: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            headlineLarge: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            headlineMedium: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            headlineSmall: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            labelLarge: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            labelMedium: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            labelSmall: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            titleLarge: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            titleMedium: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
            titleSmall: TextStyle(
              fontFamily: FontUtils.primaryFont,
              color: titleTextColor,
            ),
          ),
      scaffoldBackgroundColor: whiteColor,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.black38,
        selectionHandleColor: Colors.black,
        cursorColor: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        shadowColor: Colors.black,
        titleTextStyle: TextStyle(
          color: const Color(0xFF575D65),
          fontSize: 18,
          height: 0,
          fontFamily: FontUtils.primaryFont,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF72777E)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: false,
        fillColor: const Color(0xFFF8F8F8),
        alignLabelWithHint: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
        errorMaxLines: 2,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: FontUtils.primaryFont,
          color: const Color(0xFF9EA2A6),
          letterSpacing: 0,
          height: 0,
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: FontUtils.primaryFont,
          color: const Color(0xFF9EA2A6),
          letterSpacing: 0,
          height: 0,
        ),
        errorStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontFamily: FontUtils.primaryFont,
          color: validationErrorColor,
          letterSpacing: 0,
          height: 0,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF8F8F8), width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: validationErrorColor.withValues(alpha: 0.15), width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: validationErrorColor.withValues(alpha: 0.15), width: 1.2),
          borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          maximumSize: const Size(double.infinity, 50),
          minimumSize: const Size(double.infinity, 50),
          textStyle: TextStyle(
            fontFamily: FontUtils.primaryFont,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
          maximumSize: const Size(double.infinity, 50),
          minimumSize: const Size(double.infinity, 50),
          textStyle: TextStyle(
            fontFamily: FontUtils.primaryFont,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: whiteColor,
        constraints: BoxConstraints(maxWidth: 400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultBorderRadius),
          ),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
      ),
    );
  }

  static ThemeData get _darkTheme {
    return _lightTheme;
  }
}
