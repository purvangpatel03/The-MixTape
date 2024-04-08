import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData myTheme = ThemeData(
  scaffoldBackgroundColor: ThemeColor.primary,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeColor.primary,
    surfaceTintColor: Colors.transparent,
    foregroundColor: ThemeColor.white,
  ),
  fontFamily: "Jakarta",
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ThemeColor.primary,
    shape: const CircleBorder(),
    foregroundColor: ThemeColor.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        foregroundColor: ThemeColor.white,
        backgroundColor: ThemeColor.primary,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
      foregroundColor: ThemeColor.text,
    )
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: ThemeColor.primary,
    selectedItemColor: ThemeColor.textGreen,
    unselectedItemColor: ThemeColor.white,
  ),
  useMaterial3: true,
);