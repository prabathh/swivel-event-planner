import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/providers/post_provider.dart';
import 'package:event_planner_app/widgets/post/post_item.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts', style: AppTextStyles.title),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderColor, height: 1),
        ),
      ),
      body: postsAsync.when(
        loading: () => LoadingIndicator(height: 300),
        error: (error, stack) => ErrorView(error: 'Error: $error', height: 300),
        data: (posts) {
          return Container(
            color: AppColors.backgroundColor,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostItem(post: post);
              },
            ),
          );
        },
      ),
    );
  }
}
