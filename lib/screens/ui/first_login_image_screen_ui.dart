import 'dart:io';
import 'package:flutter/material.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/profile_picture_upload.dart';
import 'package:event_planner_app/widgets/common/button.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';

class ProfileImageScreenUI extends StatelessWidget {
  final File? image;
  final bool isLoading;
  final Function(File) onImageSelected;
  // Callbacks
  final VoidCallback onNextPressed;

  // Constructor
  const ProfileImageScreenUI({
    super.key,
    required this.image,
    required this.onNextPressed,
    required this.onImageSelected,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Space(space: 250),
                const Text('Welcome', style: AppTextStyles.heading),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'You are logged in for the first time and can upload a profile photo',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading,
                  ),
                ),
                const Space(space: 18),
                // Reusable ProfilePictureUpload widget
                ProfilePictureUpload(
                  image: image,
                  onImageSelected: onImageSelected,
                  isLoading: isLoading,
                ),
                const Spacer(),
                CustomButton(
                  buttonName: 'Next',
                  isPrimary: true,
                  rightNode: 'assets/icons/arrow_right.svg',
                  onPressed: onNextPressed,
                ),
                const Space(space: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
