import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  File? _selectedFile;

  // ✅ Open gallery
  Future<void> _pickFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File selected: ${pickedFile.name} ✅")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected ❌")),
      );
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Document '${_titleController.text}' uploaded ✅"),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.accentOrange,
        elevation: 4, // ✅ adds soft shadow
        centerTitle: true, // ✅ center align title
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8), // ✅ rounded bottom corners
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // ✅ keeps icon+text centered
          children: const [
            Icon(Icons.folder_copy, color: AppColors.buttonTextLight, size: 24),
            SizedBox(width: 8),
            Text(
              "Upload Documents",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.buttonTextLight,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.buttonTextLight),
        toolbarHeight: 40, // ✅ taller for better look
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Document Title *",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter document title" : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Upload Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonTextLight,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: Text(_selectedFile == null
                    ? "Select from Gallery"
                    : "Selected: ${_selectedFile!.path.split('/').last}"),
              ),

              if (_selectedFile != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedFile!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentOrange,
                    foregroundColor: AppColors.buttonTextLight,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text("Submit Document"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
