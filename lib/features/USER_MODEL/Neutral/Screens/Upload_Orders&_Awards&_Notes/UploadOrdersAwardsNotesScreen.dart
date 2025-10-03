import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class UploadOrdersAwardsNotesScreen extends StatefulWidget {
  const UploadOrdersAwardsNotesScreen({super.key});

  @override
  State<UploadOrdersAwardsNotesScreen> createState() =>
      _UploadOrdersAwardsNotesScreenState();
}

class _UploadOrdersAwardsNotesScreenState
    extends State<UploadOrdersAwardsNotesScreen> {
  List<Map<String, String>> uploads = [
    {
      "title": "Interim Order",
      "type": "Order",
      "date": "20 Sep 2025",
      "file": "interim_order.pdf",
    },
    {
      "title": "Final Award",
      "type": "Award",
      "date": "15 Sep 2025",
      "file": "final_award.pdf",
    },
    {
      "title": "Case Notes - C-295",
      "type": "Notes",
      "date": "10 Sep 2025",
      "file": "case_notes.docx",
    },
  ];

  void _uploadNewDocument(String type) {
    setState(() {
      uploads.add({
        "title": "$type Document ${uploads.length + 1}",
        "type": type,
        "date": "25 Sep 2025",
        "file": "${type.toLowerCase()}_${uploads.length + 1}.pdf",
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$type uploaded successfully"),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  void _removeDocument(int index) {
    String fileName = uploads[index]["file"]!;
    setState(() {
      uploads.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Removed $fileName"),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  void _showUploadMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 600, 16, 100),
      items: const [
        PopupMenuItem(value: "Order", child: Text("Upload Order")),
        PopupMenuItem(value: "Award", child: Text("Upload Award")),
        PopupMenuItem(value: "Notes", child: Text("Upload Notes")),
      ],
    ).then((value) {
      if (value != null) {
        _uploadNewDocument(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: uploads.isEmpty
          ? Center(
              child: Text(
                "No uploads yet.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: uploads.length,
              separatorBuilder: (context, index) =>
                  Divider(color: theme.dividerColor),
              itemBuilder: (context, index) {
                final doc = uploads[index];
                return Card(
                  color: theme.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: theme.dividerColor),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: Icon(
                        doc["type"] == "Order"
                            ? Icons.gavel
                            : doc["type"] == "Award"
                                ? Icons.workspace_premium
                                : Icons.note_alt,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      doc["title"]!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      "Type: ${doc["type"]}\nDate: ${doc["date"]}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
                                content: Text("Downloading ${doc["file"]}..."),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: AppColors.errorRed),
                          tooltip: "Remove",
                          onPressed: () => _removeDocument(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // ✅ Floating Action Button with theme colors
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showUploadMenu(context),
        tooltip: "Upload Document",
        child: const Icon(Icons.add, color: AppColors.buttonTextLight),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
