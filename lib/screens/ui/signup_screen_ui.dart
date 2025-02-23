import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/widgets/common/input.dart';
import 'package:event_planner_app/widgets/common/button.dart';
import 'package:event_planner_app/utils/validators.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:event_planner_app/config/text_styles.dart';

class SignUpScreenUI extends StatelessWidget {
  // Form key
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;
  final GlobalKey<FormFieldState> confirmPasswordKey;
  // Controllers for the input fields
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  // Focus nodes for the input fields
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  // Callbacks
  final VoidCallback onSubmit;
  final VoidCallback onLogInPressed;
  final bool isLoading;

  // Constructor
  const SignUpScreenUI({
    super.key,
    required this.formKey,
    required this.emailKey,
    required this.passwordKey,
    required this.confirmPasswordKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.onSubmit,
    required this.onLogInPressed,
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Space(space: 170),
                  const Text('Welcome', style: AppTextStyles.heading),
                  const Space(space: 16),
                  const Text(
                    'Welcome to your Portal',
                    style: AppTextStyles.subheading,
                  ),
                  const Space(space: 36),
                  // Email Input
                  CustomInput(
                    prefixIconPath: 'assets/icons/mail.svg',
                    title: 'Email',
                    controller: emailController,
                    validator: Validators.validateEmail,
                    focusNode: emailFocusNode,
                    fieldKey: emailKey,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  const Space(space: 16),
                  // Password Input
                  CustomInput(
                    prefixIconPath: 'assets/icons/lock.svg',
                    suffixIconPath: 'assets/icons/eye.svg',
                    title: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: Validators.validatePassword,
                    focusNode: passwordFocusNode,
                    fieldKey: passwordKey,
                    onFieldSubmitted: (value) {
                      FocusScope.of(
                        context,
                      ).requestFocus(confirmPasswordFocusNode);
                    },
                  ),
                  const Space(space: 16),
                  // Password Input
                  CustomInput(
                    prefixIconPath: 'assets/icons/lock.svg',
                    suffixIconPath: 'assets/icons/eye.svg',
                    title: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPasswordController,
                    validator:
                        (value) => Validators.validateConfirmPassword(
                          value,
                          passwordController.text,
                        ),
                    focusNode: confirmPasswordFocusNode,
                    fieldKey: confirmPasswordKey,
                    textInputAction: TextInputAction.done,
                  ),
                  const Spacer(),
                  if (isLoading)
                    const LoadingIndicator(height: 90)
                  else
                    Column(
                      children: [
                        // Login Button
                        CustomButton(
                          buttonName: 'Sign Up',
                          isPrimary: true,
                          rightNode: 'assets/icons/arrow_right.svg',
                          onPressed: onSubmit,
                        ),
                        const Space(space: 16),
                        // Sign Up Button
                        CustomButton(
                          buttonName: 'Login',
                          isPrimary: true,
                          rightNode: 'assets/icons/arrow_right.svg',
                          onPressed: onLogInPressed,
                        ),
                      ],
                    ),
                  const Space(space: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
