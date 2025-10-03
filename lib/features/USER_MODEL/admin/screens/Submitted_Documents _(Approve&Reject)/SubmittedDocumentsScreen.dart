import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class SubmittedDocumentsScreen extends StatefulWidget {
  const SubmittedDocumentsScreen({super.key});

  @override
  State<SubmittedDocumentsScreen> createState() =>
      _SubmittedDocumentsScreenState();
}

class _SubmittedDocumentsScreenState extends State<SubmittedDocumentsScreen> {
  // 🔹 Dummy data (replace with API/DB later)
  List<Map<String, dynamic>> documents = [
    {
      "docName": "Case Petition.pdf",
      "uploadedBy": "Ravi Kumar",
      "caseId": "C-1001",
      "date": "25-Sep-2025",
      "status": "Pending"
    },
    {
      "docName": "Evidence_1.jpg",
      "uploadedBy": "Neha Gupta",
      "caseId": "C-1002",
      "date": "22-Sep-2025",
      "status": "Approved"
    },
    {
      "docName": "Response.docx",
      "uploadedBy": "Anjali Verma",
      "caseId": "C-1003",
      "date": "20-Sep-2025",
      "status": "Rejected"
    },
  ];

  void _updateStatus(int index, String newStatus) {
    setState(() {
      documents[index]["status"] = newStatus;
    });
  }

  void _deleteDocument(int index) {
    setState(() {
      documents.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Submitted Documents",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
          return Card(
            color: theme.cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: const Icon(Icons.insert_drive_file,
                    color: AppColors.primary),
              ),
              title: Text(
                doc["docName"],
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Uploaded by: ${doc["uploadedBy"]}",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary)),
                    Text("Case ID: ${doc["caseId"]}",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary)),
                    Text("Date: ${doc["date"]}",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    _buildStatusBadge(doc["status"], theme),
                  ],
                ),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "approve") {
                    _updateStatus(index, "Approved");
                  } else if (value == "reject") {
                    _updateStatus(index, "Rejected");
                  } else if (value == "delete") {
                    _deleteDocument(index);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "approve",
                    child: Text("Approve"),
                  ),
                  const PopupMenuItem(
                    value: "reject",
                    child: Text("Reject"),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: "delete",
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Status Badge styled with theme
  Widget _buildStatusBadge(String status, ThemeData theme) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Pending":
        bgColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange;
        break;
      case "Approved":
        bgColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
        break;
      case "Rejected":
        bgColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: 13,
        ),
      ),
    );
  }
}
