import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  List<String> uploadedFiles = [];

  void _pickFile() {
    // For demo purpose, we just add a dummy filename
    setState(() {
      uploadedFiles.add("Document_${uploadedFiles.length + 1}.pdf");
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("File added successfully"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("File removed"),
        backgroundColor: AppColors.accentOrange,
      ),
    );
  }

  void _submitDocuments() {
    if (uploadedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload at least one document"),
          backgroundColor: AppColors.accentOrange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Documents submitted successfully!"),
        backgroundColor: AppColors.primary,
      ),
    );

    setState(() {
      uploadedFiles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.divider),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Upload button
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
                      backgroundColor: AppColors.buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _pickFile,
                  ),
                ),
                const SizedBox(height: 20),

                // Documents list
                Expanded(
                  child: uploadedFiles.isEmpty
                      ? const Center(
                          child: Text(
                            "No documents uploaded yet.",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : ListView.separated(
                          itemCount: uploadedFiles.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: AppColors.divider,
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.description,
                                  color: AppColors.iconDefault),
                              title: Text(
                                uploadedFiles[index],
                                style: const TextStyle(
                                    color: AppColors.textPrimary),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () => _removeFile(index),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 20),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send,
                        color: AppColors.buttonTextLight),
                    label: const Text(
                      "Submit Documents",
                      style: TextStyle(color: AppColors.buttonTextLight),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submitDocuments,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
