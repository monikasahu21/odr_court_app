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
        backgroundColor: AppColors.successGreen,
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Documents Workspace"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 Upload Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Document"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonTextLight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _uploadDocument,
              ),
            ),
            const SizedBox(height: 20),

            /// 🔹 Documents List
            Expanded(
              child: documents.isEmpty
                  ? Center(
                      child: Text(
                        "No documents uploaded yet.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: documents.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: theme.dividerColor),
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return Card(
                          color: theme.cardColor,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: theme.dividerColor),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.15),
                              child: const Icon(Icons.description,
                                  color: AppColors.primary),
                            ),
                            title: Text(
                              doc["title"]!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              "By: ${doc["uploadedBy"]}\nDate: ${doc["date"]}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.download),
                                  color: AppColors.primary,
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
                                  icon: const Icon(Icons.delete),
                                  color: AppColors.errorRed,
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
