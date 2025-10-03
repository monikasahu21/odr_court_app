import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Case_Information&Case_Management/CaseManagementScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Reports&Analytics/ReportsAnalyticsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Submitted_Documents%20_(Approve&Reject)/SubmittedDocumentsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Users_Management/User_ManagementScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class AdminControlsScreen extends StatelessWidget {
  const AdminControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Admin Controls",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("⚙️ System Settings", theme),
          _buildControlCard(
            context,
            icon: Icons.build,
            title: "Maintenance Mode",
            subtitle: "Enable or disable system access",
            onTap: () => _showMaintenanceDialog(context),
          ),
          _buildControlCard(
            context,
            icon: Icons.color_lens,
            title: "Theme Settings",
            subtitle: "Switch between light and dark mode",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Theme switch coming soon...")),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("👥 Management", theme),
          _buildControlCard(
            context,
            icon: Icons.people,
            title: "Users Management",
            subtitle: "View, approve, or deactivate users",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UsersManagementScreen(),
                ),
              );
            },
          ),
          _buildControlCard(
            context,
            icon: Icons.gavel,
            title: "Cases Management",
            subtitle: "Monitor and manage cases",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CaseManagementScreen(),
                ),
              );
            },
          ),
          _buildControlCard(
            context,
            icon: Icons.description,
            title: "Documents Management",
            subtitle: "Approve or reject submissions",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SubmittedDocumentsScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("📢 Communication", theme),
          _buildControlCard(
            context,
            icon: Icons.notifications,
            title: "Send Notifications",
            subtitle: "Broadcast updates to all users",
            onTap: () => _showNotificationDialog(context),
          ),
          _buildControlCard(
            context,
            icon: Icons.analytics,
            title: "Reports & Analytics",
            subtitle: "View system activity summary",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ReportsAnalyticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 Section Title
  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// 🔹 Control Card
  Widget _buildControlCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: AppColors.iconDefault),
        onTap: onTap,
      ),
    );
  }

  /// 🔹 Maintenance Mode Dialog
  void _showMaintenanceDialog(BuildContext context) {
    bool isMaintenanceEnabled = false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: const Text(
                "Maintenance Mode",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              content: Row(
                children: [
                  const Text("Enable Maintenance",
                      style: TextStyle(color: AppColors.textSecondary)),
                  const Spacer(),
                  Switch(
                    activeColor: AppColors.primary,
                    value: isMaintenanceEnabled,
                    onChanged: (val) {
                      setState(() => isMaintenanceEnabled = val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Close",
                      style: TextStyle(color: AppColors.textSecondary)),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.buttonTextLight,
                  ),
                  child: const Text("Save"),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.primary,
                        content: Text(
                          "Maintenance Mode "
                          "${isMaintenanceEnabled ? "Enabled" : "Disabled"}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 🔹 Send Notification Dialog
  void _showNotificationDialog(BuildContext context) {
    String message = "";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Send Notification",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: "Enter message",
              labelStyle: TextStyle(color: AppColors.textSecondary),
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (val) => message = val,
          ),
          actions: [
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: AppColors.textSecondary)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.buttonTextLight,
              ),
              child: const Text("Send"),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text(
                      message.isEmpty
                          ? "Notification sent"
                          : "Notification sent: $message",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
