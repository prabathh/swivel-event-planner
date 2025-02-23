import 'package:flutter/material.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/state/user_notifier.dart';
import 'first_login_image_screen.dart';
import 'signup_screen.dart';
import 'main_tab_screen.dart';
import 'ui/login_screen_ui.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  // Form field key
  final _formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  // Controllers for the input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // Focus nodes for the input fields
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Initialize the focus nodes
  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) emailKey.currentState?.validate();
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) passwordKey.currentState?.validate();
    });
  }

  // Function to show error message
  void _showError(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
  }

  // Function to log in
  Future<void> _logIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Log in user
      final user = await _authService.logIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        // Fetch user data
        await ref.read(userProvider.notifier).fetchUserData(user.uid);
        // Get user data
        final userData = ref.read(userProvider);
        // Navigate to the appropriate screen
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    userData == null || userData.imageUrl == null
                        ? const ProfilePictureUploadScreen()
                        : const MainTabScreen(),
          ),
        );
      }
    } catch (e) {
      // Show error message
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreenUI(
      formKey: _formKey,
      emailKey: emailKey,
      passwordKey: passwordKey,
      emailController: emailController,
      passwordController: passwordController,
      emailFocusNode: emailFocusNode,
      passwordFocusNode: passwordFocusNode,
      isLoading: _isLoading,
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          _logIn();
        }
      },
      onSignUpPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      onRestorePasswordPressed: () {
        // Add restore password logic here
      },
    );
  }
}
