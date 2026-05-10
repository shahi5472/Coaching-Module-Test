import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? positiveBtnText,
    String? negativeBtnText,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (dialogCtx) {
            return AlertDialog.adaptive(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text(positiveBtnText ?? "Yes"),
                  onPressed: () => Navigator.of(dialogCtx).pop(true),
                ),
                TextButton(
                  child: Text(negativeBtnText ?? "No"),
                  onPressed: () => Navigator.of(dialogCtx).pop(false),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
