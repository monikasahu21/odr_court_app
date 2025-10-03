import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name;
  String _role;
  String _email;
  String? _avatarPath; // ✅ store avatar image path

  UserProvider({
    required String name,
    required String role,
    required String email,
    String? avatarPath,
  })  : _name = name,
        _role = role,
        _email = email,
        _avatarPath = avatarPath;

  // Getters
  String get name => _name;
  String get role => _role;
  String get email => _email;
  String? get avatarPath => _avatarPath;

  // ✅ Load user data from SharedPreferences
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("userName") ?? _name;
    _role = prefs.getString("userRole") ?? _role;
    _email = prefs.getString("userEmail") ?? _email;
    _avatarPath = prefs.getString("profileImagePath") ?? _avatarPath;
    notifyListeners();
  }

  // ✅ Save all profile fields into SharedPreferences
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", _name);
    await prefs.setString("userRole", _role);
    await prefs.setString("userEmail", _email);
    if (_avatarPath != null) {
      await prefs.setString("profileImagePath", _avatarPath!);
    }
  }

  // Update full profile
  Future<void> updateProfile({
    required String name,
    required String role,
    required String email,
  }) async {
    _name = name;
    _role = role;
    _email = email;
    await _saveToPrefs(); // ✅ persist changes
    notifyListeners(); // refresh all widgets
  }

  // ✅ Update only avatar
  Future<void> updateAvatar(String path) async {
    _avatarPath = path;
    await _saveToPrefs(); // ✅ persist avatar too
    notifyListeners();
  }
}
