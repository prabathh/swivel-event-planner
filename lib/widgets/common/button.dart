import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/widgets/common/space_widget.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final String? rightNode;
  final String? leftNode;
  final bool isPrimary;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonName,
    this.rightNode,
    this.leftNode,
    this.isPrimary = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isPrimary ? AppColors.primaryColor : AppColors.secondaryColor;
    final Color textColor =
        isPrimary ? AppColors.backgroundColor : AppColors.primaryTextColor;
    final Color iconColor =
        isPrimary ? AppColors.backgroundColor : AppColors.tertiaryTextColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leftNode != null) ...[
            SvgPicture.asset(
              leftNode!,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
            const Space(space: 8, axis: Axis.horizontal),
          ],
          Text(
            buttonName,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (rightNode != null) ...[
            const Space(space: 8, axis: Axis.horizontal),
            SvgPicture.asset(
              rightNode!,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
          ],
        ],
      ),
    );
  }
}
