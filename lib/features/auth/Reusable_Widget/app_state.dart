// lib/features/auth/models/app_state.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart'; // ✅ add this import

import 'role.dart';

class AppState extends ChangeNotifier {
  Role? _role;
  String? _email;

  // ✅ Always initialized
  Locale _locale = const Locale('en'); // ✅ default always set

  Role? get role => _role;
  String? get email => _email;

  Locale get locale => _locale;

  Role get effectiveRole => _role ?? Role.claimant;

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

  void setLocale(Locale locale) {
    // ✅ now S is recognized
    if (!S.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
