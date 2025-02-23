import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:event_planner_app/state/user_notifier.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:event_planner_app/utils/image_compressor.dart';
import 'package:event_planner_app/utils/image_decoder.dart';
import 'ui/profile_screen_ui.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;

  const ProfileScreen({super.key, required this.openDrawer});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final AuthService _authService = AuthService();
  File? _image;
  File? _appBarImage;
  bool _isEditing = false;
  bool _isLoading = false;
  // GlobalKey to control the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Form field keys
  final _formKey = GlobalKey<FormState>();
  // Controllers for the input fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final mailingAddressController = TextEditingController();

  // Function to show error message
  void _showError(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
  }

  // Callback function to handle image selection
  void _handleImageSelected(File image) {
    setState(() {
      _image = image;
    });
  }

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) _saveUserProfile();
      setState(() {
        _isEditing = !_isEditing;
      });
    }
  }

  // Function to update user profile
  Future<void> _saveUserProfile() async {
    // Get the current user
    final user = ref.read(userProvider);

    if (user == null) {
      _showError("User not found");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Prepare user data map
      final Map<String, dynamic> userData = {
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "phoneNumber": phoneNumberController.text.trim(),
        "address": mailingAddressController.text.trim(),
      };

      // Convert image to Base64
      if (_image != null && _image != _appBarImage) {
        String? base64String = await ImageCompressor.compressImageToBase64(
          _image!,
        );
        userData["imageUrl"] = base64String;
      }

      // Update Firestore user data
      await _authService.updateUserProfile(user.uid, userData);

      // Refresh user data in provider
      await ref.read(userProvider.notifier).fetchUserData(user.uid);

      // Update the local state with the refreshed user data
      final refreshedUserData = ref.read(userProvider);
      if (refreshedUserData != null) {
        setState(() {
          _appBarImage = _image;
        });
      }
    } catch (e) {
      _showError("Failed to update profile: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Initialize the focus nodes
  @override
  void initState() {
    super.initState();
    final userData = ref.read(userProvider);
    if (userData != null &&
        userData.imageUrl != null &&
        userData.imageUrl!.startsWith("data:image")) {
      firstNameController.text = userData.firstName.toString();
      lastNameController.text = userData.lastName.toString();
      emailController.text = userData.email.toString();
      phoneNumberController.text = userData.phoneNumber.toString();
      mailingAddressController.text = userData.address.toString();

      // Decode the Base64 image string and assign it to _image
      ImageDecoder.convertBase64ToFile(userData.imageUrl!)
          .then((file) {
            if (file != null) {
              setState(() {
                _image = file;
                _appBarImage = file;
              });
            }
          })
          .catchError((e) {
            _showError(e.toString());
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreenUI(
      formKey: _formKey,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      emailController: emailController,
      phoneNumberController: phoneNumberController,
      mailingAddressController: mailingAddressController,
      image: _image,
      appBarImage: _appBarImage,
      isEditing: _isEditing,
      scaffoldKey: _scaffoldKey,
      isLoading: _isLoading,
      onEditToggle: _submitForm,
      onImageSelected: _handleImageSelected,
      onOpenDrawer: widget.openDrawer,
    );
  }
}
