import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_planner_app/widgets/common/input.dart';
import 'package:event_planner_app/utils/validators.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';

class ProfileInputField extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController mailingAddressController;
  final bool disabled;

  const ProfileInputField({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.mailingAddressController,
    this.disabled = false,
  });

  @override
  ConsumerState<ProfileInputField> createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends ConsumerState<ProfileInputField> {
  final firstNameKey = GlobalKey<FormFieldState>();
  final lastNameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final phoneNumberKey = GlobalKey<FormFieldState>();
  final mailingAddressKey = GlobalKey<FormFieldState>();

  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    firstNameFocusNode.addListener(() {
      if (!firstNameFocusNode.hasFocus) firstNameKey.currentState?.validate();
    });
    lastNameFocusNode.addListener(() {
      if (!lastNameFocusNode.hasFocus) lastNameKey.currentState?.validate();
    });
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) emailKey.currentState?.validate();
    });
    phoneFocusNode.addListener(() {
      if (!phoneFocusNode.hasFocus) phoneNumberKey.currentState?.validate();
    });
    addressFocusNode.addListener(() {
      if (!addressFocusNode.hasFocus)
        mailingAddressKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      // ListView for scrolling
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          CustomInput(
            title: 'First Name',
            controller: widget.firstNameController,
            validator: Validators.validateName,
            focusNode: firstNameFocusNode,
            fieldKey: firstNameKey,
            disabled: widget.disabled,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(lastNameFocusNode);
            },
          ),
          const Space(space: 24),
          CustomInput(
            title: 'Last Name',
            controller: widget.lastNameController,
            validator: Validators.validateName,
            focusNode: lastNameFocusNode,
            fieldKey: lastNameKey,
            disabled: widget.disabled,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(emailFocusNode);
            },
          ),
          const Space(space: 24),
          CustomInput(
            title: 'Email',
            controller: widget.emailController,
            validator: Validators.validateEmail,
            focusNode: emailFocusNode,
            fieldKey: emailKey,
            disabled: widget.disabled,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(phoneFocusNode);
            },
          ),
          const Space(space: 24),
          CustomInput(
            title: 'Phone Number',
            controller: widget.phoneNumberController,
            validator: Validators.validatePhoneNumber,
            focusNode: phoneFocusNode,
            fieldKey: phoneNumberKey,
            disabled: widget.disabled,
            keyboardType: TextInputType.phone,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(addressFocusNode);
            },
          ),
          const Space(space: 24),
          CustomInput(
            title: 'Mailing Address',
            controller: widget.mailingAddressController,
            validator: Validators.validateAddress,
            focusNode: addressFocusNode,
            fieldKey: mailingAddressKey,
            disabled: widget.disabled,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
