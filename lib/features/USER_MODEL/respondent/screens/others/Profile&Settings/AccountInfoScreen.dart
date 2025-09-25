import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> accountInfo = {
      "Full Name": "Rahul Sharma",
      "Email": "rahul.sharma@example.com",
      "Phone": "+91 9876543210",
      "Role": "Respondent",
      "Case ID": "Case #2024-45",
      "Status": "Active",
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          "Account Info",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: accountInfo.entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  _getIcon(entry.key),
                  color: AppColors.primary,
                ),
              ),
              title: Text(
                entry.key,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              subtitle: Text(
                entry.value,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// 🔹 Helper to assign icons for each field
  IconData _getIcon(String field) {
    switch (field) {
      case "Full Name":
        return Icons.person;
      case "Email":
        return Icons.email;
      case "Phone":
        return Icons.phone;
      case "Role":
        return Icons.security;
      case "Case ID":
        return Icons.gavel;
      case "Status":
        return Icons.verified_user;
      default:
        return Icons.info;
    }
  }
}
