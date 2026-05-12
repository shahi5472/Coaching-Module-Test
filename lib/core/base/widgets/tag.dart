import 'package:coaching_module_test/utils/manager/extensions/font_utils_extensions.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: context.labelSmall?.copyWith(
          color: textColor,
          fontWeight: .w600,
        ),
      ),
    );
  }
}
