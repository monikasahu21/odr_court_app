import 'package:flutter/material.dart';

/// Centralized color palette for the ODR app UI.
class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF1976D2); // blue (Compose button)
  static const Color accentOrange =
      Color(0xFFFB8C00); // bright orange (active menu)

  // Backgrounds
  static const Color background =
      Color(0xFFF8F9FA); // light gray page background
  static const Color cardBackground = Colors.white; // white cards/containers
  static const Color sidebarBackground = Color(0xFFFFFFFF); // white left menu

  // Text & icons
  static const Color textPrimary = Color(0xFF212121); // main dark text
  static const Color textSecondary = Color(0xFF757575); // secondary/label text
  static const Color iconDefault = Color(0xFF424242); // default icon color

  // States
  static const Color selectedMenu = accentOrange; // active menu highlight
  static const Color hoverMenu = Color(0xFFFFB74D); // lighter hover orange
  static const Color divider = Color(0xFFE0E0E0); // subtle dividers

  // Buttons
  static const Color buttonBlue = primary; // Compose / primary buttons
  static const Color buttonTextLight = Colors.white; // text on dark buttons
}
