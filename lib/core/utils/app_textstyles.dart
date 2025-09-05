import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_colors.dart';

class AppStyles {
  /// **Regular (400)** text style
  static const TextStyle regular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.black,
  );

  /// **SemiBold (600)** text style
  static const TextStyle semiBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.black,
  );

  /// **ExtraBold (800)** text style
  static const TextStyle extraBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    fontSize: 16,
    color: AppColors.black,
  );

  /// Dynamic style with custom font size
  static TextStyle regularWithSize(double size) => TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: size,
    color: AppColors.black,
  );

  static TextStyle semiBoldWithSize(double size) => TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: size,
    color: AppColors.black,
  );

  static TextStyle extraBoldWithSize(double size) => TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    fontSize: size,
    color: AppColors.black,
  );
}
