import 'dart:io';
import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/profile_avatar.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/widgets/common/text_button.dart';
import 'package:event_planner_app/state/user_notifier.dart';
import 'package:event_planner_app/utils/image_decoder.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:event_planner_app/screens/login_screen.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  final AuthService _authService = AuthService();
  File? _image;
  String _userName = '';
  String _email = '';

  // Initialize the image and user data
  @override
  void initState() {
    super.initState();
    final userData = ref.read(userProvider);

    if (userData != null) {
      setState(() {
        _userName = '${userData.firstName} ${userData.lastName}';
        _email = '${userData.email}';
      });
      if (userData.imageUrl != null &&
          userData.imageUrl!.startsWith("data:image")) {
        //Decode user image
        ImageDecoder.convertBase64ToFile(userData.imageUrl!)
            .then((file) {
              if (file != null) {
                setState(() {
                  _image = file;
                });
              }
            })
            .catchError((e) {
              debugPrint("Error decoding image: $e");
            });
      }
    }
  }

  // Function to log out user
  Future<void> _logOutUser() async {
    try {
      await _authService.logOut();
      // Navigate to LoginScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 272,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 84, bottom: 8),
              child: Row(
                children: [
                  // Profile Icon
                  ProfileAvatar(image: _image),
                  const Space(space: 16, axis: Axis.horizontal),
                  // Name and Email
                  SizedBox(
                    height: 44,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userName, style: AppTextStyles.orgName),
                        Text(_email, style: AppTextStyles.subheading),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: AppColors.borderColor),
            const Space(space: 4),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: CustomTextButton(
                text: 'Logout',
                leftIconPath: 'assets/icons/logout.svg',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.errorColor,
                onPressed: _logOutUser,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 84),
              child: Center(
                child: Text('Version 0.0.1', style: AppTextStyles.subheading),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
