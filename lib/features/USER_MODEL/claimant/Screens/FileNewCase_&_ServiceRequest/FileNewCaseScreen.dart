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
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: AppColors.accentOrange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$requestType submitted successfully!"),
        backgroundColor: AppColors.primary,
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
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
                // Request Type
                const Text(
                  "Request Type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: requestType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Description
                TextField(
                  controller: _descController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
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
                      style: const TextStyle(color: AppColors.textSecondary),
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
                        style: const TextStyle(color: AppColors.primary),
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
                    label: const Text(
                      "Submit",
                      style: TextStyle(color: AppColors.buttonTextLight),
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
