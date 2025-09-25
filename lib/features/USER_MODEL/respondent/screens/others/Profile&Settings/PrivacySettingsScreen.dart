import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool showProfilePicture = true;
  bool allowMessages = true;
  bool caseVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Privacy Settings"),
        backgroundColor: AppColors.accentOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: "Show Profile Picture",
            subtitle: "Allow others to view your profile picture",
            value: showProfilePicture,
            onChanged: (val) => setState(() => showProfilePicture = val),
          ),
          _buildSwitchTile(
            title: "Allow Direct Messages",
            subtitle: "Control if other users can send you messages",
            value: allowMessages,
            onChanged: (val) => setState(() => allowMessages = val),
          ),
          _buildSwitchTile(
            title: "Case Visibility",
            subtitle: "Show case-related activities to other parties",
            value: caseVisibility,
            onChanged: (val) => setState(() => caseVisibility = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        subtitle: Text(subtitle,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 13, height: 1.3)),
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }
}
