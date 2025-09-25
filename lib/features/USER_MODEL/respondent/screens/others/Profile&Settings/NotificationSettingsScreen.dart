import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool caseUpdates = true;
  bool paymentReminders = true;
  bool hearingAlerts = true;
  bool generalNotices = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Notification Settings"),
        backgroundColor: AppColors.accentOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: "Case Updates",
            subtitle: "Get notified when there are updates in your cases",
            value: caseUpdates,
            onChanged: (val) => setState(() => caseUpdates = val),
          ),
          _buildSwitchTile(
            title: "Payment Reminders",
            subtitle: "Receive reminders for pending or upcoming payments",
            value: paymentReminders,
            onChanged: (val) => setState(() => paymentReminders = val),
          ),
          _buildSwitchTile(
            title: "Hearing Alerts",
            subtitle: "Be notified before your virtual hearings",
            value: hearingAlerts,
            onChanged: (val) => setState(() => hearingAlerts = val),
          ),
          _buildSwitchTile(
            title: "General Notices",
            subtitle: "Receive announcements and general information",
            value: generalNotices,
            onChanged: (val) => setState(() => generalNotices = val),
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
