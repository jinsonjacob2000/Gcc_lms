import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE); // Custom Primary Color
  static const Color secondary = Color(0xFF03DAC6);
  static const Color primarywhite = Color(0xFFF5F5F5);
  static const Color primaryblue = Color.fromARGB(255, 0, 0, 128);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle subwhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primarywhite,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );
}

class AppSpacing {
  static const SizedBox hsmall = SizedBox(height: 8);
  static const SizedBox hmedium = SizedBox(height: 16);
  static const SizedBox hlarge = SizedBox(height: 24);
  static const SizedBox hextraLarge = SizedBox(height: 32);

  static const SizedBox smallWidth = SizedBox(width: 8);
  static const SizedBox mediumWidth = SizedBox(width: 16);
  static const SizedBox largeWidth = SizedBox(width: 24);
}


