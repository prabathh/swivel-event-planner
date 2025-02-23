import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'organizer_list.dart';

class Event extends ConsumerWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Space(space: 8),
        const Text('MIAMI GRAND PRIX', style: AppTextStyles.eventTitle),
        const Space(space: 14),
        const Text('Miami International Aut', style: AppTextStyles.subheading),
        const Space(space: 28),
        //  Organizer List
        const OrganizerList(),
      ],
    );
  }
}
