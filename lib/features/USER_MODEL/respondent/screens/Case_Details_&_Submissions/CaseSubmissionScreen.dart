import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CaseSubmissionScreen extends StatefulWidget {
  const CaseSubmissionScreen({super.key});

  @override
  State<CaseSubmissionScreen> createState() => _CaseSubmissionScreenState();
}

class _CaseSubmissionScreenState extends State<CaseSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _caseIdCtrl = TextEditingController();
  final TextEditingController _replyCtrl = TextEditingController();

  final List<Map<String, String>> _assignedCases = [
    {"id": "Case #2024-101", "title": "Property Dispute"},
    {"id": "Case #2024-102", "title": "Cheque Bounce"},
    {"id": "Case #2024-103", "title": "Contract Breach"},
  ];

  String? _selectedCase;
  File? _selectedFile;

  Future<void> _pickFileFromGallery() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Assigned Cases",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 12),

            // Dropdown for case selection
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              value: _selectedCase,
              hint: const Text("Select Case"),
              items: _assignedCases
                  .map((c) => DropdownMenuItem(
                        value: c["id"],
                        child: Text("${c["id"]} - ${c["title"]}"),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCase = val;
                  _caseIdCtrl.text = val ?? "";
                });
              },
            ),

            const SizedBox(height: 24),

            const Text("Submit Your Reply / Statement",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 12),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Case ID (auto-filled)
                  TextFormField(
                    controller: _caseIdCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Case ID",
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reply field
                  TextFormField(
                    controller: _replyCtrl,
                    maxLines: 6,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter your reply" : null,
                    decoration: InputDecoration(
                      labelText: "Your Reply / Written Statement",
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload button
                  ElevatedButton.icon(
                    onPressed: _pickFileFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.buttonTextLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Supporting Documents"),
                  ),

                  if (_selectedFile != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.insert_drive_file,
                              color: AppColors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _selectedFile!.path.split('/').last,
                              style: const TextStyle(
                                  color: AppColors.textSecondary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() => _selectedFile = null);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Reply submitted for $_selectedCase successfully.\nAttached: ${_selectedFile != null ? _selectedFile!.path.split('/').last : 'No file'}")));
                        _replyCtrl.clear();
                        setState(() => _selectedFile = null);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentOrange,
                      foregroundColor: AppColors.buttonTextLight,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 32),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Submit Reply"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
