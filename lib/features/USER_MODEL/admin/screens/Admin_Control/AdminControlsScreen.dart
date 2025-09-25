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
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("System Settings"),
          _buildControlCard(
            context,
            icon: Icons.build,
            title: "Maintenance Mode",
            subtitle: "Enable/disable system access",
            onTap: () {
              _showMaintenanceDialog(context);
            },
          ),
          _buildControlCard(
            context,
            icon: Icons.color_lens,
            title: "Theme Settings",
            subtitle: "Switch between light/dark mode",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Theme switch coming soon...")),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Management"),
          _buildControlCard(
            context,
            icon: Icons.people,
            title: "Users Management",
            subtitle: "View, approve or deactivate users",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const UsersManagementScreen()),
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
                MaterialPageRoute(builder: (_) => const CaseManagementScreen()),
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
                    builder: (_) => const SubmittedDocumentsScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Communication"),
          _buildControlCard(
            context,
            icon: Icons.notifications,
            title: "Send Notifications",
            subtitle: "Broadcast updates to all users",
            onTap: () {
              _showNotificationDialog(context);
            },
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
                  builder: (context) => const ReportsAnalyticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // 🔹 Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // 🔹 Control Card
  Widget _buildControlCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppColors.textSecondary)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  // 🔹 Maintenance Mode Dialog
  void _showMaintenanceDialog(BuildContext context) {
    bool isMaintenanceEnabled = false;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Maintenance Mode"),
              content: Row(
                children: [
                  const Text("Enable Maintenance"),
                  const Spacer(),
                  Switch(
                    value: isMaintenanceEnabled,
                    onChanged: (val) {
                      setState(() {
                        isMaintenanceEnabled = val;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary),
                  child: const Text("Save"),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Maintenance Mode ${isMaintenanceEnabled ? "Enabled" : "Disabled"}")),
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

  // 🔹 Send Notification Dialog
  void _showNotificationDialog(BuildContext context) {
    String message = "";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Send Notification"),
          content: TextField(
            decoration: const InputDecoration(
              labelText: "Enter message",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (val) => message = val,
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text("Send"),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Notification sent: $message")),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
