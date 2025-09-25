// lib/features/auth/models/app_state.dart
import 'package:flutter/material.dart';

import 'role.dart';

class AppState extends ChangeNotifier {
  Role? _role;
  String? _email;

  Role? get role => _role;
  String? get email => _email;

  /// Always returns a non-null Role (defaults to claimant if null)
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
}
