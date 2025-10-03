import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CaseStatusTrackingScreen extends StatefulWidget {
  const CaseStatusTrackingScreen({super.key});

  @override
  State<CaseStatusTrackingScreen> createState() =>
      _CaseStatusTrackingScreenState();
}

class _CaseStatusTrackingScreenState extends State<CaseStatusTrackingScreen> {
  List<Map<String, dynamic>> cases = [
    {
      "caseId": "C-101",
      "title": "Property Dispute with Neighbor",
      "filedOn": "10 Sep 2025",
      "status": "Hearing Scheduled",
      "timeline": [
        {"label": "Filed", "done": true},
        {"label": "Under Review", "done": true},
        {"label": "Hearing Scheduled", "done": true},
        {"label": "Resolved", "done": false},
      ]
    },
    {
      "caseId": "C-102",
      "title": "Unpaid Salary Complaint",
      "filedOn": "15 Sep 2025",
      "status": "Under Review",
      "timeline": [
        {"label": "Filed", "done": true},
        {"label": "Under Review", "done": true},
        {"label": "Hearing Scheduled", "done": false},
        {"label": "Resolved", "done": false},
      ]
    },
  ];

  /// 🔹 Show case timeline in a dialog
  void _showTimeline(Map<String, dynamic> caseData) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Case Timeline: ${caseData["caseId"]}",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: caseData["timeline"].map<Widget>((step) {
              return ListTile(
                leading: Icon(
                  step["done"]
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: step["done"]
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                title: Text(
                  step["label"],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: step["done"]
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight:
                        step["done"] ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: Text(
                "Close",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  /// 🔹 Status color mapping
  Color _statusColor(String status) {
    switch (status) {
      case "Filed":
        return Colors.grey;
      case "Under Review":
        return AppColors.accentOrange;
      case "Hearing Scheduled":
        return AppColors.primary;
      case "Resolved":
        return Colors.green;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Case Status Tracking",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cases.length,
        separatorBuilder: (context, index) => Divider(
          color: theme.dividerColor,
        ),
        itemBuilder: (context, index) {
          final caseData = cases[index];
          return Card(
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              title: Text(
                caseData["title"],
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    "Filed On: ${caseData["filedOn"]}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Status: ${caseData["status"]}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _statusColor(caseData["status"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.timeline, color: AppColors.primary),
                tooltip: "View Timeline",
                onPressed: () => _showTimeline(caseData),
              ),
            ),
          );
        },
      ),
    );
  }
}
