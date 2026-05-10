import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'manager/extensions/font_utils_extensions.dart';

class AppUtils {
  static void fullScreenDialog({required BuildContext context, required Widget child}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12.withValues(alpha: 0.2),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, _, _) => child,
    );
  }

  static Future<void> showSnackBar(BuildContext context, bool isError, String message, {String? title, bool isHideTitle = false}) async {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      type: isError ? ToastificationType.warning : ToastificationType.success,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isHideTitle) Text(title ?? (isError ? "Error" : "Success"), style: context.labelMedium),
          Text(message, style: context.labelSmall),
        ],
      ),
    );
  }
}
