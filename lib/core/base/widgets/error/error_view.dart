import 'package:flutter/material.dart';

import '../../../../utils/constansts/color_constants.dart';
import '../../../../utils/manager/extensions/font_utils_extensions.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.title = "Error",
    required this.message,
    this.onPressed,
    this.percentage = 0.8,
  });

  final String title;
  final String message;
  final VoidCallback? onPressed;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height * percentage,
      child: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: .min,
          children: [
            if (title.isNotEmpty)
              Text(
                title,
                textAlign: .center,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: validationErrorColor,
                ),
              ),
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.amber,
            ),
            if (message.isNotEmpty)
              Text(
                message,
                textAlign: .center,
                style: context.bodyLarge?.copyWith(
                  color: validationErrorColor.withValues(alpha: 0.7),
                ),
              ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
