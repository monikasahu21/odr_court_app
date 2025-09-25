import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

/// 🔹 Neutral Dashboard - Scrutinize Submissions
class ScrutinizeSubmissionsScreen extends StatelessWidget {
  const ScrutinizeSubmissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚡ Dummy Data (replace with API/DB integration)
    final submissions = [
      {
        "caseId": "Case #2024-101",
        "party": "Claimant: Amit Sharma",
        "docName": "Evidence Document.pdf",
        "date": "22 Sep 2025",
        "status": "Pending"
      },
      {
        "caseId": "Case #2024-102",
        "party": "Respondent: XYZ Pvt Ltd",
        "docName": "Reply Statement.docx",
        "date": "21 Sep 2025",
        "status": "Pending"
      },
      {
        "caseId": "Case #2024-103",
        "party": "Claimant: Riya Patel",
        "docName": "Additional Evidence.zip",
        "date": "19 Sep 2025",
        "status": "Approved"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: submissions.length,
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: AppColors.cardBackground,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.description, color: AppColors.primary),
              ),
              title: Text(
                submission["docName"]!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(submission["caseId"]!,
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text(submission["party"]!,
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Date: ${submission["date"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Status: ${submission["status"]}",
                      style: TextStyle(
                          color: submission["status"] == "Approved"
                              ? Colors.green
                              : submission["status"] == "Rejected"
                                  ? Colors.red
                                  : AppColors.accentOrange,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "${submission["docName"]} marked as $value ✅")),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Approved",
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text("Approve"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "Rejected",
                    child: Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Reject"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "Needs Revision",
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.orange),
                        SizedBox(width: 8),
                        Text("Request Revision"),
                      ],
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert, color: AppColors.iconDefault),
              ),
            ),
          );
        },
      ),
    );
  }
}
