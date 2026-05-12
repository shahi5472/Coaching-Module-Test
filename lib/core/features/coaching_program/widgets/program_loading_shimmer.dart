import 'package:coaching_module_test/core/features/coaching_program/widgets/shimmer.dart';
import 'package:coaching_module_test/utils/constansts/dimentions.dart';
import 'package:flutter/material.dart';

class ProgramLoadingShimmer extends StatelessWidget {
  const ProgramLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .8,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const Shimmer(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
            child: ColoredBox(color: Colors.grey),
          ),
        ),
        childCount: 20,
      ),
    );
  }
}
