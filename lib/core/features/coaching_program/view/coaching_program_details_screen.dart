import 'dart:convert';

import 'package:coaching_module_test/core/base/widgets/error/error_view.dart';
import 'package:coaching_module_test/core/base/widgets/image/custom_image_view.dart';
import 'package:coaching_module_test/utils/manager/extensions/font_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../routes/route_arguments_constants.dart';
import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../data/models/coaching_response_model.dart';
import '../data/usecase/get_coaching_details_usecase.dart';
import '../data/usecase/get_feed_list_usecase.dart';
import '../widgets/feed_list_view.dart';
import 'coaching_program_details_screen_controller.dart';

class CoachingProgramDetailsScreen extends StatelessWidget {
  const CoachingProgramDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CoachingProgramDetailsScreenController(
        context: ctx,
        iNavigator: iNavigator,
        coachingDetailsUseCase: sl<GetCoachingDetailsUseCase>(),
        coachingFeedListUseCase: sl<GetFeedListUseCase>(),
      )..onInit(),
      child: const _CoachingDetailsProgramWidget(),
    );
  }
}

class _CoachingDetailsProgramWidget extends StatefulWidget {
  const _CoachingDetailsProgramWidget();

  @override
  State<_CoachingDetailsProgramWidget> createState() => _CoachingDetailsProgramWidgetState();
}

class _CoachingDetailsProgramWidgetState extends State<_CoachingDetailsProgramWidget> {
  bool isRouterListener = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isRouterListener) return;

      try {
        isRouterListener = true;

        final state = GoRouterState.of(context);

        final data = state.uri.queryParameters[RouteArgumentsConstants.data];

        if (data == null || data.isEmpty) return;

        context.read<CoachingProgramDetailsScreenController>().fetchCoachingDetails(
          CoachingItem.fromJson(jsonDecode(data)),
        );
      } catch (e, st) {
        debugPrint('Error in onQueryParams: $e\n$st');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoachingProgramDetailsScreenController>(
      builder: (context, controller, _) {
        return Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.all(defaultPadding / 2),
                child: Column(
                  spacing: defaultPadding / 2,
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    DrawerHeader(
                      child: Text(
                        'Sessions',
                        style: context.titleLarge?.copyWith(fontWeight: .bold),
                      ),
                    ),
                    ...List.generate(controller.state.sessions.length, (index) {
                      final item = controller.state.sessions[index];
                      final subSessions = controller.getSubSessions(item.id);

                      return ExpansionTile(
                        title: Text(item.sessionName),
                        children: List.generate(subSessions.length, (index) {
                          final sub = subSessions[index];
                          final selected = controller.isSelectedSession(sub);

                          return ListTile(
                            selected: selected,
                            leading: Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off),
                            title: Text(sub.sessionName),
                            onTap: () async {
                              controller.iNavigator.pop(context);

                              await controller.onSessionChange(sub);
                            },
                          );
                        }),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(title: Text(controller.state.coachingDetails.title)),
          body: CustomScrollView(
            slivers: [
              controller.state.status == CoachingDetailsStatus.loading
                  ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                  : controller.state.status == CoachingDetailsStatus.failed
                  ? SliverFillRemaining(
                      child: Center(
                        child: ErrorView(
                          message: controller.state.message,
                          onPressed: controller.onRetry,
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(child: _Body()),
            ],
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CoachingProgramDetailsScreenController>();
    return Column(
      spacing: defaultPadding,
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        CustomImageView(
          path: controller.state.coachingDetails.bannerImg,
          height: 300,
          width: double.infinity,
          fit: .cover,
        ),
        if (controller.state.coachingDetails.desc.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsetsDirectional.only(start: defaultPadding, end: defaultPadding),
            child: Column(
              spacing: defaultPadding,
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Text('${controller.state.coachingDetails.meta.membersCount} members'),
                HtmlWidget(controller.state.coachingDetails.desc),
              ],
            ),
          ),
        ],
        FeedListView(controller: controller),
      ],
    );
  }
}
