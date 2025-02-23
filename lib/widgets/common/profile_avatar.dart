import 'dart:io';
import 'package:flutter/material.dart';
import 'package:event_planner_app/config/colors.dart';

class ProfileAvatar extends StatelessWidget {
  final File? image;
  final double size;

  const ProfileAvatar({
    super.key,
    this.image,
    this.size = 44, // Default size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            image == null
                ? Border.all(color: AppColors.primaryColor, width: 1)
                : null,
      ),
      child: CircleAvatar(
        backgroundImage: image != null ? FileImage(image!) : null,
        child:
            image == null
                ? const Icon(Icons.person, color: AppColors.primaryColor)
                : null,
      ),
    );
  }
}
