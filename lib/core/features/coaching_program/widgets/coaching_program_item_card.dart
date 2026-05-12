import 'package:flutter/material.dart';

import '../../../../utils/constansts/dimentions.dart';
import '../../../../utils/manager/extensions/font_utils_extensions.dart';
import '../../../base/widgets/image/custom_image_view.dart';

class CoachingProgramItemCard extends StatelessWidget {
  const CoachingProgramItemCard({
    super.key,
    this.onPressed,
    required this.image,
    required this.title,
    required this.memberCount,
    required this.status,
  });

  final VoidCallback? onPressed;
  final String image;
  final String title;
  final int memberCount;
  final String status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImageView(
                    path: image,
                    height: 130,
                    width: double.infinity,
                    fit: .cover,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(defaultBorderRadius),
                      topRight: Radius.circular(defaultBorderRadius),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 12,
                    end: 12,
                    bottom: 12,
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: context.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: defaultPadding / 2,
                vertical: defaultPadding / 2,
              ),
              child: Row(
                spacing: 4,
                mainAxisSize: .min,
                children: [
                  const Icon(Icons.group_outlined, size: 16),
                  Text(
                    "Member: $memberCount",
                    style: context.labelMedium,
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    alignment: .center,
                    padding: const EdgeInsetsDirectional.all(4),
                    child: Text(
                      status,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: context.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
