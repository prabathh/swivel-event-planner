import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePictureUpload extends StatelessWidget {
  final File? image;
  final Function(File) onImageSelected;
  final bool isLoading;
  final bool disabled;
  final bool editForm;

  // Constructor
  const ProfilePictureUpload({
    super.key,
    this.image,
    required this.isLoading,
    required this.onImageSelected,
    this.disabled = false,
    this.editForm = false,
  });

  // Function to open the image picker
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
  }

  // Function to show the image source options
  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          isLoading || disabled
              ? null
              : () =>
                  _showImageSourceOptions(context), // Avoid upload if disabled
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 116,
            height: 116,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            child:
                isLoading
                    ? LoadingIndicator(height: 116)
                    : image != null
                    ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 116,
                        height: 116,
                        fit: BoxFit.cover,
                      ),
                    )
                    : Center(
                      child: SvgPicture.asset(
                        'assets/icons/camera.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
          ),
          if (editForm && !disabled)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.backgroundColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
