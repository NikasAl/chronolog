import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0A0A0C); // Void Black
  static const Color surface = Color(0xFF1E1E24);    // Card Surface
  
  static const Color primary = Color(0xFFFFD700);    // Gold (Time)
  static const Color accent = Color(0xFF00E5FF);     // Neon (Cherenkov)
  static const Color error = Color(0xFFFF3D00);      // Red (Event Horizon)
  
  static const Color textMain = Colors.white;
  static const Color textDim = Colors.white54;
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      // Стиль текстовых полей (Input)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.white10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        labelStyle: const TextStyle(color: AppColors.textDim),
      ),
      // Шрифт
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Monospace', color: AppColors.textMain),
        headlineMedium: TextStyle(fontFamily: 'Monospace', fontWeight: FontWeight.bold, color: AppColors.primary),
        titleMedium: TextStyle(fontFamily: 'Monospace', color: AppColors.accent),
      ),
    );
  }
}