import 'package:event_planner_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/button.dart';
import 'package:event_planner_app/widgets/profile_input_field.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';

class ProfileInfoScreenUI extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController mailingAddressController;
  final VoidCallback onBackPressed;
  final VoidCallback onNextPressed;
  final bool isLoading;

  const ProfileInfoScreenUI({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.mailingAddressController,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Space(space: 64),
            // Title Text
            const Text('Personal info', style: AppTextStyles.title),
            const SizedBox(height: 8),
            // Subtitle Text
            const Text(
              'You can add your personal data now or do it later',
              style: AppTextStyles.subheading,
            ),
            const Space(space: 22),
            // Wrap ProfileInputField in Expanded
            Expanded(
              child: SingleChildScrollView(
                child: ProfileInputField(
                  formKey: formKey,
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  phoneNumberController: phoneNumberController,
                  mailingAddressController: mailingAddressController,
                ),
              ),
            ),
            // Buttons Row with fixed bottom margin
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 46,
                child:
                    isLoading
                        ? LoadingIndicator()
                        : Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                buttonName: 'Back',
                                isPrimary: false,
                                leftNode: 'assets/icons/arrow_left.svg',
                                onPressed: onBackPressed,
                              ),
                            ),
                            const Space(space: 10, axis: Axis.horizontal),
                            Expanded(
                              child: CustomButton(
                                buttonName: 'Next',
                                isPrimary: true,
                                rightNode: 'assets/icons/arrow_right.svg',
                                onPressed: onNextPressed,
                              ),
                            ),
                          ],
                        ),
              ),
            ),
            // Conditionally add Space(space: 40) only when the keyboard is not open
            AnimatedPadding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 40 : 0,
              ),
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
