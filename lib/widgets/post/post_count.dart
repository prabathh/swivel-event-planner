import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/providers/post_provider.dart';
import 'package:event_planner_app/screens/post_screen.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postProvider);
    return postsAsync.when(
      data: (comments) {
        final postCount = comments.length;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostScreen()),
            );
          },
          child: Container(
            height: 60,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderColor, width: 2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$postCount', style: AppTextStyles.postCount),
                const Text('Posts', style: AppTextStyles.subheading),
                const Space(space: 10),
              ],
            ),
          ),
        );
      },
      loading: () => LoadingIndicator(),
      error: (error, stackTrace) => ErrorView(error: 'Failed to load comments'),
    );
  }
}
