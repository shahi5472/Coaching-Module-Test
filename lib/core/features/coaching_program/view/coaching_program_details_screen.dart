import 'dart:convert';

import 'package:coaching_module_test/core/base/widgets/error/error_view.dart';
import 'package:coaching_module_test/core/base/widgets/image/custom_image_view.dart';
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
import '../widgets/session_drawer.dart';
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
          drawer: SessionDrawer(
            item: controller.state.oldData,
            sessions: controller.state.sessions,
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
