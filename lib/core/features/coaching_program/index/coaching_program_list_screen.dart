import 'package:coaching_module_test/core/base/widgets/error/error_view.dart';
import 'package:coaching_module_test/core/base/widgets/fields/custom_text_form_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../data/usecase/coaching_list_usecase.dart';
import '../widgets/coaching_program_item_card.dart';
import 'coaching_program_list_screen_controller.dart';

class CoachingProgramListScreen extends StatelessWidget {
  const CoachingProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CoachingProgramListScreenController(
        context: ctx,
        iNavigator: iNavigator,
        coachingListUseCase: sl<CoachingListUseCase>(),
      )..onInit(),
      child: const _CoachingProgramWidget(),
    );
  }
}

class _CoachingProgramWidget extends StatelessWidget {
  const _CoachingProgramWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<CoachingProgramListScreenController>(
      builder: (context, controller, _) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar.medium(
                  pinned: true,
                  title: const Text('My Coaching'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    child: CustomTextFormView(
                      hintText: 'Search programs',
                      controller: controller.searchEditController,
                      onChanged: controller.onSearchChanged,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.all(defaultPadding),
                  sliver: controller.state.status == CoachingListStatus.loading
                      ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
                      : controller.state.status == CoachingListStatus.failed
                      ? SliverFillRemaining(
                          child: Center(
                            child: ErrorView(
                              message: controller.state.message,
                              onPressed: controller.onRefresh,
                            ),
                          ),
                        )
                      : SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: .8,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = controller.state.items[index];
                              return CoachingProgramItemCard(
                                image: item.cover,
                                title: item.title,
                                memberCount: item.totalMembers,
                                status: item.status,
                                onPressed: () => controller.navigate(item),
                              );
                            },
                            childCount: controller.state.items.length,
                          ),
                        ),
                ),
                if (controller.state.status == CoachingListStatus.loadingMore) ...[
                  const SliverPadding(
                    padding: EdgeInsetsDirectional.all(defaultPadding),
                    sliver: SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
