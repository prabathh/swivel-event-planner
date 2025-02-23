import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';
import 'package:event_planner_app/config/colors.dart';

class CustomInput extends StatefulWidget {
  final String? prefixIconPath;
  final String title;
  final bool isPassword;
  final TextEditingController controller;
  final String? suffixIconPath;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final GlobalKey<FormFieldState>? fieldKey;
  final bool disabled;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;

  const CustomInput({
    super.key,
    this.prefixIconPath,
    required this.title,
    this.isPassword = false,
    required this.controller,
    this.suffixIconPath,
    this.validator,
    this.focusNode,
    this.fieldKey,
    this.disabled = false,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input Title
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(widget.title, style: AppTextStyles.inputTitle),
        ),
        const Space(space: 8),
        // TextFormField with SVG Icons
        TextFormField(
          key: widget.fieldKey,
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          validator: widget.validator,
          focusNode: widget.focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: !widget.disabled,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: AppTextStyles.input,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor:
                widget.disabled
                    ? AppColors.inputDisableColor
                    : AppColors.secondaryColor,
            contentPadding: const EdgeInsets.only(top: 14, left: 14),
            prefixIcon:
                widget.prefixIconPath != null
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        widget.prefixIconPath!,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.tertiaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                    : null,
            suffixIcon:
                widget.suffixIconPath != null
                    ? IconButton(
                      icon: SvgPicture.asset(
                        widget.suffixIconPath ?? 'assets/icons/eye.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.tertiaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : const SizedBox.shrink(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.tertiaryTextColor,
                width: 0.8,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor, width: 0.8),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
