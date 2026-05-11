import 'package:coaching_module_test/core/base/widgets/fields/custom_text_form_view.dart';
import 'package:coaching_module_test/utils/constansts/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../data/models/get_feed__list_response_model.dart';
import '../view/coaching_program_details_screen_controller.dart';

class FeedListView extends StatelessWidget {
  final CoachingProgramDetailsScreenController controller;

  const FeedListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final items = controller.state.feedData.data;
    if (items.isEmpty) {
      return const Center(child: Text('No Feed Found'));
    }

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: List.generate(items.length, (index) {
        final item = items[index];

        switch (item.feedType.toLowerCase()) {
          // case 'lesson':
          //   return const SizedBox();

          case 'task':
            return TaskFeedCard(item: item);

          case 'journal':
            return JournalFeedCard(item: item);

          default:
            return const SizedBox();
        }
      }),
    );
  }
}

class TaskFeedCard extends StatelessWidget {
  final FeedItem item;

  const TaskFeedCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final tracker = item.parsedFeedData;

    if (tracker is FeedDataModel) {
      final data = tracker;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.taskExercise.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(data.taskExercise.description),

            const SizedBox(height: 16),

            if (data.taskExercise.uploadFiles.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: data.taskExercise.uploadFiles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    final file = data.taskExercise.uploadFiles[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        file.meta.fileLink,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 20),

            const Text(
              'Tracker Inputs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...tracker.tracker.inputs.map(
              (input) {
                switch (input.type.toLowerCase()) {
                  case 'question':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: CustomTextFormView(hintText: input.label),
                    );

                  case 'number':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: CustomTextFormView(
                        keyboardType: TextInputType.number,
                        hintText: '${input.label} (${input.unit})',
                      ),
                    );

                  case 'select one':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: DropdownButtonFormField<String>(
                        items: input.options
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          labelText: input.label,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    );

                  case 'duration':
                    return Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(defaultBorderRadius),
                          ),
                          child: Text(input.label),
                        ),
                      ),
                    );

                  default:
                    return const SizedBox();
                }
              },
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}

class JournalFeedCard extends StatelessWidget {
  final FeedItem item;

  const JournalFeedCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final journal = item.parsedFeedData;

    if (journal is JournalFeedData) {
      final data = journal.journal;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            HtmlWidget(data.description),

            const SizedBox(height: 16),

            const CustomTextFormView(
              maxLines: 6,
              hintText: 'Write your journal...',
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit Journal'),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
