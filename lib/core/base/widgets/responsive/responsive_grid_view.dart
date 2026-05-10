import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../utils/constansts/dimentions.dart';

class CustomBreakResponsiveGrid extends StatelessWidget {
  const CustomBreakResponsiveGrid({
    super.key,
    this.children = const [],
    required this.crossAxisCount,
    this.mainAxisSpacing = defaultPadding,
    this.crossAxisSpacing = defaultPadding,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      children: List.generate(children.length, (index) {
        return StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: children[index],
        );
      }),
    );
  }
}
