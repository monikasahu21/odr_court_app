import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class DocumentsWorkspaceScreen extends StatefulWidget {
  const DocumentsWorkspaceScreen({super.key});

  @override
  State<DocumentsWorkspaceScreen> createState() =>
      _DocumentsWorkspaceScreenState();
}

class _DocumentsWorkspaceScreenState extends State<DocumentsWorkspaceScreen> {
  List<Map<String, String>> documents = [
    {
      "title": "Petition Document",
      "uploadedBy": "Claimant (Amit Sharma)",
      "date": "12 Sep 2025",
      "file": "petition_doc.pdf"
    },
    {
      "title": "Respondent Reply",
      "uploadedBy": "Respondent (Priya Singh)",
      "date": "15 Sep 2025",
      "file": "response_doc.pdf"
    },
    {
      "title": "Supporting Evidence",
      "uploadedBy": "Claimant (Amit Sharma)",
      "date": "18 Sep 2025",
      "file": "evidence1.pdf"
    },
  ];

  void _uploadDocument() {
    setState(() {
      documents.add({
        "title": "Additional Response",
        "uploadedBy": "Respondent (Priya Singh)",
        "date": "25 Sep 2025",
        "file": "additional_response.pdf"
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Document uploaded successfully"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _removeDocument(int index) {
    String fileName = documents[index]["file"]!;
    setState(() {
      documents.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed $fileName"),
        backgroundColor: AppColors.accentOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Upload Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file,
                    color: AppColors.buttonTextLight),
                label: const Text(
                  "Upload Document",
                  style: TextStyle(color: AppColors.buttonTextLight),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _uploadDocument,
              ),
            ),
            const SizedBox(height: 20),

            // Documents List
            Expanded(
              child: documents.isEmpty
                  ? const Center(
                      child: Text(
                        "No documents uploaded yet.",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.separated(
                      itemCount: documents.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: AppColors.divider),
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return Card(
                          color: AppColors.cardBackground,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColors.divider),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.description,
                                color: AppColors.iconDefault),
                            title: Text(
                              doc["title"]!,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "By: ${doc["uploadedBy"]}\nDate: ${doc["date"]}",
                              style: const TextStyle(
                                  color: AppColors.textSecondary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.download,
                                      color: AppColors.primary),
                                  tooltip: "Download",
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Downloading ${doc["file"]}..."),
                                        backgroundColor: AppColors.primary,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  tooltip: "Remove",
                                  onPressed: () => _removeDocument(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
