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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              offset: const Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          spacing: defaultPadding / 2,
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Stack(
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
                PositionedDirectional(
                  top: 12,
                  end: 12,
                  child: Container(
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                title,
                maxLines: 2,
                overflow: .ellipsis,
                style: context.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                "Member: $memberCount",
                style: context.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
