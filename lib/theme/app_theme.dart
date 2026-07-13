import 'package:flutter/material.dart';

class AppTheme {
  // Farben
  static const Color background = Color(0xFF08111F);
  static const Color card = Color(0xFF13243D);
  static const Color primary = Color(0xFF1EB6FF);
  static const Color accent = Color(0xFF58D0FF);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,

      scaffoldBackgroundColor: background,

      primaryColor: primary,

      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: card,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        centerTitle: true,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
  color: card,
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
  ),
),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      useMaterial3: true,
    );
  }
}