import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/models/comment_modal.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final bool fullContent;

  const CommentItem({
    super.key,
    required this.comment,
    this.fullContent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fullContent ? AppColors.tertiaryColor : AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.name, style: AppTextStyles.commentName),
            if (fullContent) ...[
              const Space(space: 2),
              Text(comment.email, style: AppTextStyles.input),
            ],
            const Space(space: 6),
            Text(
              comment.body,
              maxLines: fullContent ? null : 3,
              overflow:
                  fullContent ? TextOverflow.visible : TextOverflow.ellipsis,
              style: AppTextStyles.subheading,
            ),
          ],
        ),
      ),
    );
  }
}
