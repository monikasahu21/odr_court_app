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
    return Scaffold(
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: const Icon(Icons.insert_drive_file,
                    color: AppColors.primary),
              ),
              title: Text(doc["docName"],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Uploaded by: ${doc["uploadedBy"]}"),
                  Text("Case ID: ${doc["caseId"]}"),
                  Text("Date: ${doc["date"]}"),
                  Text("Status: ${doc["status"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _statusColor(doc["status"]),
                      )),
                ],
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
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
