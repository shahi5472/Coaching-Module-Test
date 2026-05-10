import 'package:flutter/material.dart';

import 'custom_responsive.dart';

class SimpleRowColumnWidget extends StatelessWidget {
  const SimpleRowColumnWidget({
    super.key,
    this.spacing = 0.0,
    required this.children,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    this.rowCrossAxisAlignment = CrossAxisAlignment.end,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
  });

  final double spacing;
  final List<Widget> children;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (context.isMobileView) {
      return Column(
        spacing: spacing,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: columnCrossAxisAlignment,
        mainAxisAlignment: columnMainAxisAlignment,
        children: List.generate(children.length, (index) {
          final child = children[index];
          if (child is Expanded) {
            return child.child;
          } else if (child is Flexible) {
            return child.child;
          } else {
            return child;
          }
        }),
      );
    }
    return Row(
      spacing: spacing,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: rowCrossAxisAlignment,
      mainAxisAlignment: rowMainAxisAlignment,
      children: children,
    );
  }
}

class CustomBreakpointSimpleRowColumnWidget extends StatelessWidget {
  const CustomBreakpointSimpleRowColumnWidget({
    super.key,
    this.spacing = 0.0,
    this.isColumnView = false,
    required this.children,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    this.rowCrossAxisAlignment = CrossAxisAlignment.end,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
  });

  final double spacing;
  final bool isColumnView;
  final List<Widget> children;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (isColumnView) {
      return Column(
        spacing: spacing,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: columnCrossAxisAlignment,
        mainAxisAlignment: columnMainAxisAlignment,
        children: List.generate(children.length, (index) {
          final child = children[index];
          if (child is Expanded) {
            return child.child;
          } else if (child is Flexible) {
            return child.child;
          } else {
            return child;
          }
        }),
      );
    }
    return Row(
      spacing: spacing,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: rowCrossAxisAlignment,
      mainAxisAlignment: rowMainAxisAlignment,
      children: children,
    );
  }
}
