import 'package:coaching_module_test/core/base/widgets/completion_chip.dart';
import 'package:coaching_module_test/core/base/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/coaching_details_response_model.dart';
import '../view/coaching_program_details_screen_controller.dart';

class ParentSessionTile extends StatelessWidget {
  const ParentSessionTile({
    super.key,
    required this.session,
    required this.selected,
    required this.expanded,
    required this.onTapHeader,
    required this.onChildTap,
  });

  final Session session;
  final bool selected;
  final bool expanded;
  final VoidCallback onTapHeader;
  final ValueChanged<Session> onChildTap;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CoachingProgramDetailsScreenController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.blueAccent.withValues(alpha: 0.08) : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? Colors.blueAccent.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.12),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: PageStorageKey(session.id),
          initiallyExpanded: expanded,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          childrenPadding: const EdgeInsets.only(
            left: 16,
            right: 8,
            bottom: 8,
          ),
          onExpansionChanged: (_) => onTapHeader(),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent.withValues(alpha: 0.12),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.blueAccent,
              size: 18,
            ),
          ),
          title: Text(
            session.sessionName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(session.sessionDate),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (session.completionRequired != 0) CompletionChip(pct: session.completionRequired),
              if (session.isCurrent == 1) ...[
                const SizedBox(width: 6),
                const Tag(
                  text: 'Current',
                  backgroundColor: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ],
              if (controller.hasSubSession(session.id))
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.expand_more),
                ),
            ],
          ),
          children: controller.hasSubSession(session.id)
              ? controller.getSubSessions(session.id).map((c) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: _ChildSessionTile(
                      session: c,
                      isSelected: selected,
                      onTap: () => onChildTap(c),
                      accent: Colors.blueAccent,
                    ),
                  );
                }).toList()
              : [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: _ChildSessionTile(
                      session: session,
                      isSelected: selected,
                      onTap: () => onChildTap(session),
                      accent: Colors.blueAccent,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}

class _ChildSessionTile extends StatelessWidget {
  const _ChildSessionTile({
    required this.session,
    required this.isSelected,
    required this.onTap,
    required this.accent,
  });

  final Session session;
  final bool isSelected;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final completed = session.isCompleted == 0;
    final green = Colors.green.shade600;

    return Material(
      color: completed ? green.withValues(alpha: 0.08) : (isSelected ? accent.withValues(alpha: 0.10) : Colors.transparent),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: completed ? green.withValues(alpha: 0.18) : accent.withValues(alpha: 0.12),
                child: Icon(
                  completed ? Icons.check : Icons.calendar_month_outlined,
                  size: 16,
                  color: completed ? green : accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  session.sessionName,
                  style: TextStyle(
                    color: completed ? green : null,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (session.isCurrent == 1)
                Tag(
                  text: 'Current',
                  backgroundColor: accent,
                  textColor: Colors.white,
                ),
              if (session.completionRequired != 0 && !completed) ...[
                const SizedBox(width: 6),
                CompletionChip(pct: session.completionRequired),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
