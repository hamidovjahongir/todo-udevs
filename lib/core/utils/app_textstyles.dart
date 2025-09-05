import 'package:flutter/material.dart';

class AppStyles {
  /// **Regular (400)** text style
  static const TextStyle regular = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  /// **SemiBold (600)** text style
  static const TextStyle semiBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  /// **ExtraBold (800)** text style
  static const TextStyle extraBold = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    fontSize: 16,
  );

  /// Dynamic style with custom font size
  static TextStyle regularWithSize(double size) => TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        fontSize: size,
      );

  static TextStyle semiBoldWithSize(double size) => TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: size,
      );

  static TextStyle extraBoldWithSize(double size) => TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w800,
        fontSize: size,
      );
}
