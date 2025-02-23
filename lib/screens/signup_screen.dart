import 'package:flutter/material.dart';
import 'package:event_planner_app/services/auth_service.dart';
import 'login_screen.dart';
import 'ui/signup_screen_ui.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  // Form field keys
  final _formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();
  //  Controllers for the input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Focus nodes for the input fields
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

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
    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus)
        confirmPasswordKey.currentState?.validate();
    });
  }

  // Function to show error message
  void _showError(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
  }

  // Function to sign up the user
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    // Call the signUp method from the AuthService
    try {
      await _authService.signUp(emailController.text, passwordController.text);
      // Check if the widget is still mounted before navigating
      if (!mounted) return;
      // Navigate to the LoginScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignUpScreenUI(
      formKey: _formKey,
      emailKey: emailKey,
      passwordKey: passwordKey,
      confirmPasswordKey: confirmPasswordKey,
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      emailFocusNode: emailFocusNode,
      passwordFocusNode: passwordFocusNode,
      confirmPasswordFocusNode: confirmPasswordFocusNode,
      isLoading: _isLoading,
      onSubmit: () {
        if (_formKey.currentState!.validate()) {
          _signUp();
        }
      },
      onLogInPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }
}
