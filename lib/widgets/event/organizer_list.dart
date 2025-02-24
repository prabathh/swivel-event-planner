import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/providers/organizers_provider.dart';

class OrganizerList extends ConsumerWidget {
  const OrganizerList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the organizersProvider
    final organizersAsyncValue = ref.watch(organizersProvider);

    return organizersAsyncValue.when(
      data: (organizers) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Organizers', style: AppTextStyles.eventSubTitle),
            const Space(space: 16),
            SizedBox(
              height: 270,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: organizers.length,
                itemBuilder: (context, index) {
                  final organizer = organizers[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(organizer.name, style: AppTextStyles.orgName),
                          const SizedBox(height: 4),
                          Text(
                            organizer.email,
                            style: AppTextStyles.subheading,
                          ),
                        ],
                      ),
                      trailing: SvgPicture.asset(
                        'assets/icons/message.svg',
                        width: 36,
                        height: 36,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      // Show a loading spinner while the organizers are loading
      loading: () => LoadingIndicator(height: 270),
      // Show an error message if the organizers fail to load
      error:
          (error, stackTrace) =>
              ErrorView(height: 270, error: 'Failed to load organizers'),
    );
  }
}
