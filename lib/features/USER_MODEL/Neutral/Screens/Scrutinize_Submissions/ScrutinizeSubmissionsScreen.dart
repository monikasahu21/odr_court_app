import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ScrutinizeSubmissionsScreen extends StatefulWidget {
  const ScrutinizeSubmissionsScreen({super.key});

  @override
  State<ScrutinizeSubmissionsScreen> createState() =>
      _ScrutinizeSubmissionsScreenState();
}

class _ScrutinizeSubmissionsScreenState
    extends State<ScrutinizeSubmissionsScreen> {
  List<Map<String, String>> submissions = [
    {
      "title": "Initial Petition",
      "uploadedBy": "Claimant (Amit Sharma)",
      "date": "12 Sep 2025",
      "file": "petition_doc.pdf",
      "status": "Pending",
    },
    {
      "title": "Preliminary Response",
      "uploadedBy": "Respondent (Priya Singh)",
      "date": "15 Sep 2025",
      "file": "response_doc.pdf",
      "status": "Pending",
    },
    {
      "title": "Supporting Evidence",
      "uploadedBy": "Claimant (Amit Sharma)",
      "date": "18 Sep 2025",
      "file": "evidence1.pdf",
      "status": "Approved",
    },
  ];

  void _updateStatus(int index, String newStatus) {
    setState(() {
      submissions[index]["status"] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Submission '${submissions[index]["title"]}' marked as $newStatus."),
        backgroundColor: newStatus == "Approved"
            ? AppColors.successGreen
            : AppColors.errorRed,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Approved":
        return AppColors.successGreen;
      case "Rejected":
        return AppColors.errorRed;
      case "Pending":
        return AppColors.accentOrange;
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
          "Scrutinize Submissions",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: submissions.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return Card(
            color: theme.cardColor,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Title
                  Text(
                    submission["title"]!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 🔹 Info
                  Text("Uploaded By: ${submission["uploadedBy"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Date: ${submission["date"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("File: ${submission["file"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),

                  // 🔹 Status
                  Text(
                    "Status: ${submission["status"]}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: _statusColor(submission["status"]!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 🔹 Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.check_circle),
                        label: const Text("Approve"),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.successGreen,
                        ),
                        onPressed: submission["status"] == "Pending"
                            ? () => _updateStatus(index, "Approved")
                            : null,
                      ),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        icon: const Icon(Icons.cancel),
                        label: const Text("Reject"),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.errorRed,
                        ),
                        onPressed: submission["status"] == "Pending"
                            ? () => _updateStatus(index, "Rejected")
                            : null,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
