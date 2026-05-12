import 'package:coaching_module_test/utils/constansts/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../../../../app/config/globals.dart';
import '../../../../utils/dependency_injection/custom_getit.dart';
import '../../../base/widgets/error/error_view.dart';
import '../data/usecase/get_coaching_note_usecase.dart';
import 'note_bottom_sheet_controller.dart';

class NotesBottomSheet extends StatelessWidget {
  const NotesBottomSheet({
    super.key,
    this.scrollController,
    required this.coachingProgramId,
  });

  final ScrollController? scrollController;
  final int coachingProgramId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NoteBottomSheetController(
        context: ctx,
        iNavigator: iNavigator,
        getCoachingNoteUseCase: sl<GetCoachingNoteUseCase>(),
      )..fetchCoachingNote(coachingProgramId: coachingProgramId),
      child: _NotesBottomSheetWidget(scrollController: scrollController),
    );
  }
}

class _NotesBottomSheetWidget extends StatelessWidget {
  const _NotesBottomSheetWidget({this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteBottomSheetController>(
      builder: (context, controller, _) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverAppBar(
              title: Text("Coaching Notes"),
              pinned: true,
            ),
            if (controller.state.status == CoachingNoteStatus.loading) ...[
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            ] else if (controller.state.status == CoachingNoteStatus.failed || controller.state.items.isEmpty) ...[
              SliverFillRemaining(
                child: Center(
                  child: ErrorView(
                    message: controller.state.items.isEmpty ? "No item found" : controller.state.message,
                    onPressed: controller.onRetry,
                  ),
                ),
              ),
            ] else ...[
              SliverPadding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: defaultPadding),
                sliver: SliverList.separated(
                  itemCount: controller.state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.state.items[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2,
                        ),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: .min,
                          crossAxisAlignment: .start,
                          children: [
                            Text(item.title),
                            HtmlWidget(item.note),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
