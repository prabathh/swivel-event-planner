import 'package:flutter/material.dart';
import 'package:event_planner_app/config/text_styles.dart';

class ErrorView extends StatelessWidget {
  final double height; // Height of the SizedBox
  final String error; // Error message

  const ErrorView({
    super.key,
    this.height = 65, // Default height
    this.error = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(child: Text(error, style: AppTextStyles.error)),
    );
  }
}
