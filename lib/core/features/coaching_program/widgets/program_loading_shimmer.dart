import 'package:coaching_module_test/core/features/coaching_program/widgets/shimmer.dart';
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
        (context, index) => Shimmer(child: Container(color: Colors.grey)),
        childCount: 20,
      ),
    );
  }
}
