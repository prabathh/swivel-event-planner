import 'package:event_planner_app/config/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double height; // Height of the SizedBox
  final Color color; // Color of the CircularProgressIndicator

  const LoadingIndicator({
    super.key,
    this.height = 65, // Default height
    this.color = AppColors.primaryColor, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(child: CircularProgressIndicator(color: color)),
    );
  }
}
