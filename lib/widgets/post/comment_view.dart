import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/models/post_modal.dart';
import 'package:event_planner_app/models/comment_modal.dart';
import 'comment_item.dart';

class CommentScreen extends StatelessWidget {
  final Post post;
  final List<Comment> comments;

  const CommentScreen({super.key, required this.post, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post ${post.id}', style: AppTextStyles.title),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderColor, height: 1),
        ),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return CommentItem(comment: comment, fullContent: true);
          },
        ),
      ),
    );
  }
}
