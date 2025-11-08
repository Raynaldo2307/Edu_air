import 'package:flutter/material.dart';

class AppTheme {
  // Gradient: Sky to Sea Blue
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFB2EBF2), // light sky blue
      Color(0xFF0288D1), // rich sea blue
    ],
  );

  // Color palette
  static const Color primaryColor = Color(0xFF0288D1); // Deep Sea Blue
  static const Color secondaryColor = Color(0xFFB2EBF2); // Light Sky Blue
  static const Color white = Colors.white;
  static const Color accent = Color(0xFFE1F5FE); // Soft complementary blue
  static const Color textPrimary = Color(0xFF0D47A1); // Strong readable blue
  static const Color textOnWhite = Colors.black87;
}