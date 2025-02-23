import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:event_planner_app/config/colors.dart';

class CustomTextButton extends StatelessWidget {
  // Controllers for the input fields
  final String text;
  final String? leftIconPath;
  final String? rightIconPath;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;

  // Constructor
  const CustomTextButton({
    super.key,
    required this.text,
    this.leftIconPath,
    this.rightIconPath,
    required this.onPressed,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.fontColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIconPath != null) ...[
            SvgPicture.asset(
              leftIconPath!,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                fontColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
          if (rightIconPath != null) ...[
            const SizedBox(width: 8),
            SvgPicture.asset(
              rightIconPath!,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                fontColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ],
      ),
    );
  }
}