import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:event_planner_app/state/user_notifier.dart';
import 'package:event_planner_app/utils/image_compressor.dart';
import 'first_login_info_screen.dart';
import 'ui/first_login_image_screen_ui.dart';

class ProfilePictureUploadScreen extends ConsumerStatefulWidget {
  const ProfilePictureUploadScreen({super.key});

  @override
  ConsumerState<ProfilePictureUploadScreen> createState() =>
      _ProfilePictureUploadScreenState();
}

class _ProfilePictureUploadScreenState extends ConsumerState<ProfilePictureUploadScreen> {
  final AuthService _authService = AuthService();
  File? _image;
  bool _isLoading = false;

  // Function to show error message
  void _showError(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error), backgroundColor: Colors.red),
    );
  }

  // Function to handle image selection
  void _handleImageSelected(File image) {
    setState(() {
      _image = image;
    });
  }

  // Function to upload profile picture
  Future<void> _uploadProfilePicture() async {
    // Get user data
    final user = ref.read(userProvider);
    if (_image == null) {
      _showError("Please select an image");
      return;
    }
    if (user == null) {
      _showError("User not found");
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    try {
      // Convert image to Base64
      String? base64String = await ImageCompressor.compressImageToBase64(_image!);

      // Update Firestore user data
      await _authService.createUserProfile(user.uid, {'imageUrl': base64String});

      // Navigate to FirstLoginProfileInfoScreen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FirstLoginProfileInfoScreen(),
          ),
        );
      }
    } catch (e) {
      // Show error message
      _showError(e.toString());
    } finally {
      // Reset loading state
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileImageScreenUI(
      image: _image,
      onNextPressed: _uploadProfilePicture,
      onImageSelected: _handleImageSelected,
      isLoading: _isLoading,
    );
  }
}
