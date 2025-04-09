import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE); // Custom Primary Color
  static const Color secondaryBlack = Colors.black87; // Custom Secondary Color
  static const Color primarywhite = Color(0xFFF5F5F5);
  static const Color primaryblue = Color.fromARGB(255, 0, 0, 128);
  static const Color secondaryGrey = Colors.grey;
  static const Color primarygrey = Color.fromARGB(255, 245, 237, 237);
  static const Color appTheme = Color.fromARGB(134, 0, 0, 0);
  static const Color primarygreen = Color.fromARGB(133, 22, 197, 36);
   // Custom Secondary Color
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

   static const TextStyle largewhite = TextStyle(
    fontSize: 22,
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
  static const SizedBox hsmall = SizedBox(height: 6);
  static const SizedBox hmedium = SizedBox(height: 16);
  static const SizedBox hlarge = SizedBox(height: 24);
  static const SizedBox hextraLarge = SizedBox(height: 32);

  static const SizedBox smallWidth = SizedBox(width: 8);
  static const SizedBox mediumWidth = SizedBox(width: 16);
  static const SizedBox largeWidth = SizedBox(width: 24);
}


