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
        backgroundColor:
            newStatus == "Approved" ? AppColors.primary : Colors.redAccent,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.redAccent;
      case "Pending":
        return AppColors.accentOrange;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: submissions.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.divider),
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return Card(
            color: AppColors.cardBackground,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.divider),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    submission["title"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("Uploaded By: ${submission["uploadedBy"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Date: ${submission["date"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("File: ${submission["file"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),

                  // Status
                  Text(
                    "Status: ${submission["status"]}",
                    style: TextStyle(
                      color: _statusColor(submission["status"]!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon:
                            const Icon(Icons.check_circle, color: Colors.green),
                        label: const Text("Approve",
                            style: TextStyle(color: Colors.green)),
                        onPressed: submission["status"] == "Pending"
                            ? () => _updateStatus(index, "Approved")
                            : null,
                      ),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        icon: const Icon(Icons.cancel, color: Colors.redAccent),
                        label: const Text("Reject",
                            style: TextStyle(color: Colors.redAccent)),
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
