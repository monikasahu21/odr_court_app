import 'package:flutter/material.dart';

/// Centralized color palette for the ODR app UI.
class AppColors {
  // Status / semantic colors
  static const Color successGreen = Color(0xFF2E7D32); // success
  static const Color errorRed = Color(0xFFD32F2F); // error

  // Primary brand colors
  static const Color primary = Color(0xFF1976D2); // blue
  static const Color accentOrange = Color(0xFFFB8C00); // bright orange

  // Backgrounds (light mode defaults)
  static const Color background = Color(0xFFF8F9FA); // light gray
  static const Color cardBackground = Colors.white; // white cards/containers
  static const Color sidebarBackground = Color(0xFFFFFFFF); // white left menu

  // Dark mode backgrounds
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSidebar = Color(0xFF1C1C1C);

  // Text & icons
  static const Color textPrimary = Color(0xFF212121); // main dark text
  static const Color textSecondary = Color(0xFF757575); // secondary
  static const Color iconDefault = Color(0xFF424242); // default icon

  // Dark mode text
  static const Color darkTextPrimary = Colors.white; // white text
  static const Color darkTextSecondary = Colors.white70; // lighter gray
  static const Color darkIcon = Colors.white70;

  // States
  static const Color selectedMenu = accentOrange; // active menu highlight
  static const Color hoverMenu = Color(0xFFFFB74D); // lighter hover orange
  static const Color divider = Color(0xFFE0E0E0); // subtle dividers

  // Buttons
  static const Color buttonBlue = primary;
  static const Color buttonTextLight = Colors.white;
}

/// ✅ App-wide light & dark themes
class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardBackground,
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.sidebarBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.accentOrange,
      foregroundColor: AppColors.buttonTextLight,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.textPrimary,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconDefault),
    dividerColor: AppColors.divider,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.accentOrange),
      trackColor:
          WidgetStatePropertyAll(AppColors.accentOrange.withOpacity(0.5)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.darkSidebar,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkCard,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.darkTextPrimary,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkIcon),
    dividerColor: Colors.grey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentOrange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.accentOrange),
      trackColor:
          WidgetStatePropertyAll(AppColors.accentOrange.withOpacity(0.5)),
    ),
  );
}
