import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class SubmittedDocumentsScreen extends StatefulWidget {
  const SubmittedDocumentsScreen({super.key});

  @override
  State<SubmittedDocumentsScreen> createState() =>
      _SubmittedDocumentsScreenState();
}

class _SubmittedDocumentsScreenState extends State<SubmittedDocumentsScreen> {
  // Example document data (replace with DB/API later)
  final List<Map<String, String>> documents = [
    {
      "docId": "DOC-101",
      "title": "Property Agreement",
      "submittedBy": "Ravi Kumar",
      "date": "15 Sept 2025",
      "status": "Pending"
    },
    {
      "docId": "DOC-102",
      "title": "Contract Copy",
      "submittedBy": "Priya Sharma",
      "date": "17 Sept 2025",
      "status": "Approved"
    },
    {
      "docId": "DOC-103",
      "title": "Payment Receipt",
      "submittedBy": "Amit Verma",
      "date": "18 Sept 2025",
      "status": "Rejected"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final doc = documents[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doc ID + Date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doc["docId"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          doc["date"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Title
                    Text(
                      doc["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Submitted By
                    Row(
                      children: [
                        const Icon(Icons.account_circle,
                            color: AppColors.primary, size: 18),
                        const SizedBox(width: 6),
                        Text("Submitted by: ${doc["submittedBy"]}",
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Status + Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(
                            doc["status"]!,
                            style: TextStyle(
                              color: _getStatusColor(doc["status"]!),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor:
                              _getStatusColor(doc["status"]!).withOpacity(0.15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Row(
                          children: [
                            // 👁 VIEW
                            IconButton(
                              icon: const Icon(Icons.visibility,
                                  color: AppColors.primary),
                              tooltip: "View Document",
                              onPressed: () {
                                _showDocumentDetailsDialog(context, doc);
                              },
                            ),

                            // ✅ APPROVE
                            IconButton(
                              icon: const Icon(Icons.check_circle,
                                  color: Colors.green),
                              tooltip: "Approve Document",
                              onPressed: () {
                                setState(() {
                                  documents[index]["status"] = "Approved";
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Document ${doc["docId"]} approved ✅"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                            ),

                            // ❌ REJECT
                            IconButton(
                              icon: const Icon(Icons.cancel,
                                  color: Colors.redAccent),
                              tooltip: "Reject Document",
                              onPressed: () {
                                setState(() {
                                  documents[index]["status"] = "Rejected";
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Document ${doc["docId"]} rejected ❌"),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              },
                            ),

                            // 🗑 DELETE
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.black87),
                              tooltip: "Delete Document",
                              onPressed: () {
                                _confirmDeleteDoc(context, index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper for status colors
  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  // View document details
  void _showDocumentDetailsDialog(
      BuildContext context, Map<String, String> doc) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc["title"]!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
                const SizedBox(height: 12),
                Text("Document ID: ${doc["docId"]}"),
                Text("Submitted By: ${doc["submittedBy"]}"),
                Text("Date: ${doc["date"]}"),
                Text("Status: ${doc["status"]}"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text("Close"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Confirm delete document
  void _confirmDeleteDoc(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Delete Document"),
          content: const Text("Are you sure you want to delete this document?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  documents.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
