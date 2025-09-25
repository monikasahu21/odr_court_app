import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/models/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSettingScreen extends StatefulWidget {
  const AdminSettingScreen({super.key});

  @override
  State<AdminSettingScreen> createState() => _AdminSettingScreenState();
}

class _AdminSettingScreenState extends State<AdminSettingScreen> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool autoAssignCases = true;
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔹 Profile Header
          _buildProfileHeader(),
          const SizedBox(height: 24),

          // 🔹 System Settings
          const Text(
            "System Settings",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: "Enable Notifications",
            subtitle: "Get notified for case updates and reports",
            value: notificationsEnabled,
            onChanged: (val) => setState(() => notificationsEnabled = val),
          ),
          _divider(),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            subtitle: "Switch between light and dark theme",
            value: darkMode,
            onChanged: (val) => setState(() => darkMode = val),
          ),
          _divider(),
          _buildSwitchTile(
            icon: Icons.assignment,
            title: "Auto-Assign Cases",
            subtitle: "Automatically assign cases to advocates",
            value: autoAssignCases,
            onChanged: (val) => setState(() => autoAssignCases = val),
          ),
          _divider(),
          ListTile(
            leading: _buildIcon(Icons.language, AppColors.accentOrange),
            title: const Text("App Language",
                style: TextStyle(color: AppColors.textPrimary)),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: "English", child: Text("English")),
                DropdownMenuItem(value: "Hindi", child: Text("Hindi")),
                DropdownMenuItem(value: "Marathi", child: Text("Marathi")),
              ],
              onChanged: (val) {
                if (val != null) setState(() => selectedLanguage = val);
              },
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Account Management
          const Text(
            "Account Management",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: _buildIcon(Icons.logout, Colors.redAccent),
            title: const Text("Logout",
                style: TextStyle(color: AppColors.textPrimary)),
            onTap: () => _showLogoutDialog(context),
          ),
          _divider(),
          ListTile(
            leading: _buildIcon(Icons.refresh, Colors.blue),
            title: const Text("Reset System",
                style: TextStyle(color: AppColors.textPrimary)),
            subtitle: const Text("Clear all temporary system data",
                style: TextStyle(color: AppColors.textSecondary)),
            onTap: () => _showResetDialog(context),
          ),
        ],
      ),
    );
  }

  // 🔹 Logout Confirmation
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              // Clear saved session or token
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              if (mounted) {
                Navigator.pop(ctx); // close dialog
                // ✅ Navigate to login screen & clear navigation stack
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // 🔹 Reset System Confirmation
  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Reset System"),
        content:
            const Text("This will clear all temporary system data. Continue?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // clear local storage

              if (mounted) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("System reset successful")),
                );
              }
            },
            child: const Text("Reset"),
          ),
        ],
      ),
    );
  }

  // 🔹 Profile Header Widget
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentOrange,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(Icons.admin_panel_settings,
                size: 40, color: AppColors.accentOrange),
          ),
          const SizedBox(height: 12),
          const Text(
            "Admin User",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonTextLight),
          ),
          const SizedBox(height: 4),
          const Text(
            "admin@courtapp.com",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 18),
            label: const Text("Edit Profile"),
          )
        ],
      ),
    );
  }

  // 🔹 Reusable Switch Tile
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      value: value,
      activeColor: AppColors.accentOrange,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          _buildIcon(icon, AppColors.accentOrange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: AppColors.textPrimary, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 44),
        child: Text(subtitle,
            style: const TextStyle(color: AppColors.textSecondary)),
      ),
      onChanged: onChanged,
    );
  }

  // 🔹 Divider
  Widget _divider() => const Divider(height: 0);

  // 🔹 Icon Container
  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
