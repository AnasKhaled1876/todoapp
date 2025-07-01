import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: const Color(0xFFFF7700), // Orange from logo
  primaryColorDark: const Color(0xFF333333), // Dark gray from logo
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFF7700),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFF7700),
    foregroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFFFF7700),
    secondary: const Color(0xFF333333),
    onPrimary: Colors.white,
    surface: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF7700),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Color(0xFF333333),
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(color: Color(0xFF333333)),
    bodyMedium: TextStyle(color: Color(0xFF333333)),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF333333)),
);
