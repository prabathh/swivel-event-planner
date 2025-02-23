import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/widgets/common/text_button.dart';
import 'horizontal_image_list.dart';

class PhotosList extends ConsumerWidget {
  const PhotosList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Space(space: 20),
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Photos', style: AppTextStyles.eventSubTitle),
            CustomTextButton(
              text: 'All Photos',
              rightIconPath: 'assets/icons/arrow_right.svg',
              onPressed: () {
                //TODO: Add All Photos logic here
              },
            ),
          ],
        ),
        const Space(space: 12),
        // Horizontal List of Images
        const HorizontalImageList(),
      ],
    );
  }
}
