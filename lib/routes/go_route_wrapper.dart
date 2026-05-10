import 'package:flutter/widgets.dart';

import '../app/model/base/base_interfaces/i_dependencies.dart';

class GoRouteWrapper extends StatefulWidget {
  const GoRouteWrapper({
    required this.child,
    required this.routeName,
    this.onInit,
    this.onChangeDependencies,
    this.onAfterLayout,
    this.onDispose,
    this.iDependencies,
    this.dependencies,
    super.key,
  });

  final String routeName;
  final Widget child;
  final void Function()? onInit;
  final void Function(BuildContext context)? onChangeDependencies;
  final void Function(BuildContext context)? onAfterLayout;
  final void Function(BuildContext context)? onDispose;
  final IDependencies? iDependencies;
  final List<IDependencies>? dependencies;

  @override
  State<GoRouteWrapper> createState() => _GoRouteWrapperState();
}

class _GoRouteWrapperState extends State<GoRouteWrapper> {
  @override
  void initState() {
    super.initState();
    widget.iDependencies?.dependencies();

    if (widget.dependencies != null && widget.dependencies!.isNotEmpty) {
      for (final dependency in widget.dependencies!) {
        dependency.dependencies();
      }
    }

    widget.onInit?.call();

    if (widget.onAfterLayout == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAfterLayout?.call(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.onChangeDependencies?.call(context);
  }

  @override
  void dispose({String? tag}) {
    widget.onDispose?.call(context);
    widget.iDependencies?.dispose();

    if (widget.dependencies != null && widget.dependencies!.isNotEmpty) {
      for (final dependency in widget.dependencies!) {
        dependency.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
