import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:event_planner_app/widgets/common/profile_avatar.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:event_planner_app/widgets/common/profile_picture_upload.dart';
import 'package:event_planner_app/widgets/common/button.dart';
import 'package:event_planner_app/widgets/profile_input_field.dart';

class ProfileScreenUI extends StatelessWidget {
  // Form key
  final GlobalKey<FormState> formKey;
  // Controllers for the input fields
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController mailingAddressController;
  // Control values
  final File? image;
  final File? appBarImage;
  final bool isEditing;
  final bool isLoading;
  final GlobalKey<ScaffoldState> scaffoldKey;
  // Callbacks
  final VoidCallback onEditToggle;
  final Function(File) onImageSelected;
  final VoidCallback onOpenDrawer;

  const ProfileScreenUI({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.mailingAddressController,
    required this.image,
    required this.appBarImage,
    required this.isEditing,
    required this.isLoading,
    required this.scaffoldKey,
    required this.onEditToggle,
    required this.onImageSelected,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: ProfileAvatar(image: appBarImage),
          onPressed: onOpenDrawer,
        ),
        title: Text(
          isEditing ? 'Edit Profile' : 'Profile',
          style: AppTextStyles.title,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderColor, height: 1),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ProfilePictureUpload(
                        image: image,
                        onImageSelected: onImageSelected,
                        isLoading: (appBarImage != image) && isLoading,
                        disabled: !isEditing,
                        editForm: true,
                      ),
                      const Space(space: 24),
                      ProfileInputField(
                        formKey: formKey,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        phoneNumberController: phoneNumberController,
                        mailingAddressController: mailingAddressController,
                        disabled: !isEditing,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    isLoading
                        ? LoadingIndicator(height: 55)
                        : CustomButton(
                          buttonName: isEditing ? 'Save' : 'Edit',
                          isPrimary: true,
                          onPressed: onEditToggle,
                        ),
              ),
            ),
            const Space(space: 6),
          ],
        ),
      ),
    );
  }
}
