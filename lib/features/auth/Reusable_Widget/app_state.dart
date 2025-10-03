import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart'; // for supportedLocales
import 'package:shared_preferences/shared_preferences.dart'; // ✅ persist language & theme

import 'role.dart';

class AppState extends ChangeNotifier {
  Role? _role;
  String? _email;

  Locale _locale = const Locale('en'); // ✅ default language
  bool _isDarkMode = false; // ✅ default = light theme

  Role? get role => _role;
  String? get email => _email;

  Locale get locale => _locale;
  bool get isDarkMode => _isDarkMode;

  Role get effectiveRole => _role ?? Role.claimant;

  // -------------------------------
  // 🔹 AUTH MANAGEMENT
  // -------------------------------
  void login(String email, Role role) {
    _email = email;
    _role = role;
    notifyListeners();
  }

  void setRole(Role r) {
    _role = r;
    notifyListeners();
  }

  void logout() {
    _email = null;
    _role = null;
    notifyListeners();
  }

  // -------------------------------
  // 🔹 LANGUAGE MANAGEMENT
  // -------------------------------
  Future<void> setLocale(Locale locale) async {
    // ✅ Ensure supported locale
    if (!S.supportedLocales
        .map((loc) => loc.languageCode)
        .contains(locale.languageCode)) {
      return;
    }

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("appLanguageCode", locale.languageCode);
  }

  Future<void> clearLocale() async {
    _locale = const Locale('en');
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("appLanguageCode");
  }

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString("appLanguageCode") ?? "en";

    final supported = S.supportedLocales.firstWhere(
      (loc) => loc.languageCode == code,
      orElse: () => const Locale("en"),
    );

    _locale = supported;
    notifyListeners();
  }

  // -------------------------------
  // 🔹 THEME MANAGEMENT (Dark Mode)
  // -------------------------------
  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", value);
  }

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    notifyListeners();
  }

  // -------------------------------
  // 🔹 COMBINED LOADING (Locale + Theme)
  // -------------------------------
  Future<void> initializeAppSettings() async {
    await loadSavedLocale();
    await loadSavedTheme();
  }
}
