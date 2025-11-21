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
  static const Color grey = Color(0xFF9E9E9E);
  static const Color accent = Color(0xFFE1F5FE); // Soft complementary blue
  static const Color textPrimary = Color(0xFF0D47A1); // Strong readable blue
  static const Color textOnWhite = Colors.black87;

  // Material 3 enhancements
  static const Color surface = Color(0xFFFDFDFD); // Surface background
  static const Color surfaceVariant = Color(0xFFE0F7FA); // Light variant
  static const Color outline = Color(0xFFB0BEC5); // Soft gray border
  static const Color shadow = Colors.black26; // Standard shadow
  static const Color tertiary = Color(0xFF4DD0E1); // Accent teal
}
