import 'package:coaching_module_test/utils/manager/extensions/font_utils_extensions.dart';
import 'package:flutter/material.dart';

class CompletionChip extends StatelessWidget {
  const CompletionChip({super.key, required this.pct});

  final int pct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$pct%',
        style: context.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: .w600,
        ),
      ),
    );
  }
}
