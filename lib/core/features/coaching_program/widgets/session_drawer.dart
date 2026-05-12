import 'package:coaching_module_test/core/base/widgets/image/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/coaching_details_response_model.dart';
import '../data/models/coaching_response_model.dart';
import '../view/coaching_program_details_screen_controller.dart';
import 'parent_session_tile.dart';

class SessionDrawer extends StatelessWidget {
  const SessionDrawer({
    super.key,
    required this.item,
    required this.sessions,
  });

  final CoachingItem item;
  final List<Session> sessions;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CoachingProgramDetailsScreenController>();
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 0.80,
      child: Column(
        children: [
          _DrawerHeader(item: item),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: sessions.length,
              itemBuilder: (context, i) {
                final session = sessions[i];
                final isSelected = controller.isSelectedSession(session);
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + (50 * i)),
                  curve: Curves.easeOut,
                  builder: (context, t, child) => Opacity(
                    opacity: t,
                    child: Transform.translate(
                      offset: Offset(0, (1 - t) * 12),
                      child: child,
                    ),
                  ),
                  child: ParentSessionTile(
                    session: session,
                    selected: isSelected,
                    expanded: false,
                    onTapHeader: () {},
                    onChildTap: (val) async {
                      controller.iNavigator.pop(context);

                      await controller.onSessionChange(val);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({required this.item});

  final CoachingItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            path: item.cover,
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.black87],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: const [
                      Shadow(blurRadius: 4, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.totalMembers} members',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
