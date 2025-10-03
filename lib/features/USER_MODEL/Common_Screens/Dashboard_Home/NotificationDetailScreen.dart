import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 2,
        title: Text(
          "Notification Details",
          style: textTheme.titleLarge?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.buttonTextLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.buttonTextLight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.divider),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Title
                Text(
                  notification['title'] ?? "No Title",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // 🔹 Case ID
                Row(
                  children: [
                    const Icon(Icons.folder, color: AppColors.accentOrange),
                    const SizedBox(width: 8),
                    Text(
                      notification['caseId'] ?? "N/A",
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColors.darkTextPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 🔹 Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: AppColors.accentOrange),
                    const SizedBox(width: 8),
                    Text(
                      notification['date'] ?? "N/A",
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.brightness == Brightness.dark
                            ? AppColors.darkTextPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 🔹 More Details Header
                Text(
                  "More Details:",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),

                // 🔹 Description
                Text(
                  "This is a system generated notification related to ${notification['caseId'] ?? "this case"}. "
                  "Please review the details in your dashboard.",
                  style: textTheme.bodyMedium?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
