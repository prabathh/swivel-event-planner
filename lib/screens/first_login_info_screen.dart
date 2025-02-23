import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:event_planner_app/state/user_notifier.dart';
import 'first_login_image_screen.dart';
import 'ui/first_login_info_screen_ui.dart';
import 'main_tab_screen.dart';

class FirstLoginProfileInfoScreen extends ConsumerStatefulWidget {
  const FirstLoginProfileInfoScreen({super.key});

  @override
  ConsumerState<FirstLoginProfileInfoScreen> createState() =>
      _FirstLoginProfileInfoState();
}

class _FirstLoginProfileInfoState
    extends ConsumerState<FirstLoginProfileInfoScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  // Form field keys
  final _formKey = GlobalKey<FormState>();
  // Controllers for the input fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final mailingAddressController = TextEditingController();

  // Function to submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _saveUserProfile();
    }
  }

  // Function to show error message
  void _showError(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
  }

  // Function to save user profile
  Future<void> _saveUserProfile() async {
    // Get user data
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
        "firstTimeLogin": false,
      };

      // Update Firestore user data
      await _authService.updateUserProfile(user.uid, userData);

      // Refresh user data in provider
      await ref.read(userProvider.notifier).fetchUserData(user.uid);

      // Navigate to main screen
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainTabScreen()),
        );
      }
    } catch (e) {
      _showError("Failed to save profile: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileInfoScreenUI(
      formKey: _formKey,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      emailController: emailController,
      phoneNumberController: phoneNumberController,
      mailingAddressController: mailingAddressController,
      onBackPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfilePictureUploadScreen(),
          ),
        );
      },
      onNextPressed: _submitForm,
      isLoading: _isLoading,
    );
  }
}
