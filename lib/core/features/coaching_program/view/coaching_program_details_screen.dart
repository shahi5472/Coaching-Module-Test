import 'dart:convert';

import 'package:coaching_module_test/core/base/widgets/error/error_view.dart';
import 'package:coaching_module_test/core/base/widgets/image/custom_image_view.dart';
import 'package:coaching_module_test/utils/manager/extensions/font_utils_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../routes/route_arguments_constants.dart';
import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../bottom_sheet/notes_bottom_sheet.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          key: _scaffoldKey,
          drawer: SessionDrawer(
            item: controller.state.oldData,
            sessions: controller.state.sessions,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 220,
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                title: Text(
                  controller.state.oldData.title,
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.sticky_note_2_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        barrierColor: Colors.black12.withValues(alpha: 0.2),
                        backgroundColor: Colors.transparent,
                        builder: (_) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.8,
                            minChildSize: 0.4,
                            maxChildSize: 0.8,
                            expand: false,
                            builder: (context, scrollController) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(defaultBorderRadius)),
                                ),
                                child: NotesBottomSheet(
                                  coachingProgramId: controller.state.oldData.coachingProgramId,
                                  scrollController: scrollController,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImageView(
                        path: controller.state.coachingDetails.bannerImg,
                        fit: BoxFit.cover,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black54, Colors.transparent, Colors.black87],
                            stops: [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        start: 16,
                        end: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.state.oldData.title,
                              style: context.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${controller.state.oldData.totalMembers} members',
                              style: context.bodySmall?.copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        FeedListView(controller: controller),
      ],
    );
  }
}
