import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/error.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:event_planner_app/widgets/common/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/models/post_modal.dart';
import 'package:event_planner_app/providers/post_provider.dart';
import 'comment_item.dart';
import 'comment_view.dart';

class PostItem extends ConsumerWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentProvider(post.id));

    return Card(
      color: AppColors.tertiaryColor,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: AppTextStyles.title),
            const Space(space: 8),
            Text(
              post.body,
              style: AppTextStyles.subheading,
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            const Space(space: 16),
            commentsAsync.when(
              loading: () => LoadingIndicator(height: 100),
              error:
                  (error, stack) =>
                      ErrorView(error: 'Error: $error', height: 100),
              data: (comments) {
                return Column(
                  children: [
                    ...comments
                        .take(2)
                        .map((comment) => CommentItem(comment: comment)),
                    if (comments.length > 2)
                      CustomTextButton(
                        text: 'Show All Comments',
                        rightIconPath: 'assets/icons/arrow_right.svg',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CommentScreen(
                                    post: post,
                                    comments: comments,
                                  ),
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
