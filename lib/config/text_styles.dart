// lib/config/text_styles.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.25,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle subheading = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.secondaryTextColor,
  );

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 19,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle inputTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.tertiaryTextColor,
  );

  static const TextStyle input = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle error = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.errorColor,
  );

  static const TextStyle eventTitle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 26,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle eventSubTitle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 22,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle orgName = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle postCount = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 19,
    color: AppColors.primaryColor,
  );

  static const TextStyle commentName = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.primaryTextColor,
  );

  static const TextStyle bottomNav = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    //color: AppColors.primaryTextColor,
  );
}
