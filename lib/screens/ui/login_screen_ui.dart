import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/widgets/common/input.dart';
import 'package:event_planner_app/widgets/common/button.dart';
import 'package:event_planner_app/widgets/common/text_button.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:event_planner_app/utils/validators.dart';
import 'package:event_planner_app/config/text_styles.dart';

class LoginScreenUI extends StatelessWidget {
  // Form key
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> emailKey;
  final GlobalKey<FormFieldState> passwordKey;
  // Controllers for the input fields
  final TextEditingController emailController;
  final TextEditingController passwordController;
  // Focus nodes for the input fields
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  // Callbacks
  final VoidCallback onSubmit;
  final VoidCallback onSignUpPressed;
  final VoidCallback onRestorePasswordPressed;
  final bool isLoading;

  // Constructor
  const LoginScreenUI({
    super.key,
    required this.formKey,
    required this.emailKey,
    required this.passwordKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onSubmit,
    required this.onSignUpPressed,
    required this.onRestorePasswordPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(16.0),
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
                  Space(space: 36),
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
                    validator: Validators.validatePasswordLogin,
                    focusNode: passwordFocusNode,
                    fieldKey: passwordKey,
                    textInputAction: TextInputAction.done,
                  ),
                  const Space(space: 8),
                  // Restore Password Text Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      text: 'Restore Password',
                      rightIconPath: 'assets/icons/arrow_up.svg',
                      onPressed: onRestorePasswordPressed,
                    ),
                  ),
                  const Spacer(),
                  if (isLoading)
                    const LoadingIndicator(height: 90)
                  else
                    Column(
                      children: [
                        CustomButton(
                          buttonName: 'Login',
                          isPrimary: true,
                          rightNode: 'assets/icons/arrow_right.svg',
                          onPressed: onSubmit,
                        ),
                        const Space(space: 16),
                        CustomButton(
                          buttonName: 'Sign Up',
                          isPrimary: true,
                          rightNode: 'assets/icons/arrow_right.svg',
                          onPressed: onSignUpPressed,
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
