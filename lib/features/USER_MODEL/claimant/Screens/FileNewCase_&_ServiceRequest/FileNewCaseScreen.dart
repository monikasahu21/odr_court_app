import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class FileNewCaseScreen extends StatefulWidget {
  const FileNewCaseScreen({super.key});

  @override
  State<FileNewCaseScreen> createState() => _FileNewCaseScreenState();
}

class _FileNewCaseScreenState extends State<FileNewCaseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String requestType = "Case";
  bool fileAttached = false;

  void _submitRequest() {
    if (_titleController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please fill all fields"),
          backgroundColor: AppColors.accentOrange,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$requestType submitted successfully!"),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    _titleController.clear();
    _descController.clear();
    setState(() {
      requestType = "Case";
      fileAttached = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "File New Case",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
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
                // Request Type
                Text(
                  "Request Type",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: requestType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: theme.cardColor,
                  ),
                  items: const [
                    DropdownMenuItem(value: "Case", child: Text("Case")),
                    DropdownMenuItem(
                        value: "Service Request",
                        child: Text("Service Request")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      requestType = val!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Title
                TextField(
                  controller: _titleController,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: theme.cardColor,
                  ),
                ),
                const SizedBox(height: 20),

                // Description
                TextField(
                  controller: _descController,
                  maxLines: 5,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: theme.cardColor,
                  ),
                ),
                const SizedBox(height: 20),

                // File Attachment
                Row(
                  children: [
                    Icon(Icons.attach_file, color: AppColors.iconDefault),
                    const SizedBox(width: 8),
                    Text(
                      fileAttached ? "File attached" : "No file attached",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          fileAttached = !fileAttached;
                        });
                      },
                      child: Text(
                        fileAttached ? "Remove" : "Attach File",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send,
                        color: AppColors.buttonTextLight),
                    label: Text(
                      "Submit",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.buttonTextLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submitRequest,
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
