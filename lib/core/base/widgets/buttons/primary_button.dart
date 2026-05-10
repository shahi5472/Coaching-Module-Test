import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.loaderSize = 30,
    this.borderRadius = 8,
    this.maximumSize,
  });

  final String title;
  final bool isLoading;
  final VoidCallback? onPressed;

  /// Button customization
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final Size? maximumSize;

  /// Loader size
  final double loaderSize;

  /// Border radius
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = backgroundColor ?? theme.elevatedButtonTheme.style?.backgroundColor?.resolve({});
    final fgColor = foregroundColor ?? theme.elevatedButtonTheme.style?.foregroundColor?.resolve({}) ?? Colors.white;

    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? 0, height ?? 48),
        maximumSize: maximumSize,
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: fgColor,
              size: loaderSize,
            )
          : Text(
              title,
              style: TextStyle(color: fgColor),
            ),
    );
  }
}
