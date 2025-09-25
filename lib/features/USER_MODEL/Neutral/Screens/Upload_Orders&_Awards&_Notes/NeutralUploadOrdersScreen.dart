import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeutralUploadOrdersScreen extends StatefulWidget {
  const NeutralUploadOrdersScreen({super.key});

  @override
  State<NeutralUploadOrdersScreen> createState() =>
      _NeutralUploadOrdersScreenState();
}

class _NeutralUploadOrdersScreenState extends State<NeutralUploadOrdersScreen> {
  List<Map<String, dynamic>> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _loadUploadedFiles();
  }

  /// 🔹 Load saved files when screen opens
  Future<void> _loadUploadedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList("uploadedFiles") ?? [];
    setState(() {
      uploadedFiles =
          savedData.map((e) => json.decode(e) as Map<String, dynamic>).toList();
    });
  }

  /// 🔹 Save files persistently
  Future<void> _saveUploadedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final data = uploadedFiles.map((e) => json.encode(e)).toList();
    await prefs.setStringList("uploadedFiles", data);
  }

  /// 🔹 Pick file
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'txt'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      setState(() {
        uploadedFiles.add({
          "name": file.name,
          "path": file.path,
          "date": DateTime.now().toString().substring(0, 16),
        });
      });

      await _saveUploadedFiles();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploaded: ${file.name}")),
      );
    }
  }

  /// 🔹 Delete file
  Future<void> _deleteFile(int index) async {
    setState(() {
      uploadedFiles.removeAt(index);
    });
    await _saveUploadedFiles();
  }

  /// 🔹 Preview file
  Future<void> _previewFile(String path) async {
    if (path == null || path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File path not found")),
      );
      return;
    }
    final result = await OpenFilex.open(path);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open file: ${result.message}")),
      );
    }
  }

  /// 🔹 Download/Share file
  Future<void> _downloadFile(String path, String name) async {
    if (!File(path).existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File no longer exists")),
      );
      return;
    }
    await Share.shareXFiles([XFile(path)], text: "Download $name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _pickFile,
        backgroundColor: AppColors.buttonBlue,
        icon: const Icon(Icons.upload_file),
        label: const Text("Upload"),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: uploadedFiles.isEmpty
                ? const Center(
                    child: Text(
                      "No files uploaded yet.\nClick the upload button to add.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    itemCount: uploadedFiles.length,
                    itemBuilder: (context, index) {
                      final file = uploadedFiles[index];

                      Color borderColor;
                      if (file["name"].toString().endsWith(".pdf")) {
                        borderColor = Colors.redAccent;
                      } else if (file["name"].toString().endsWith(".docx")) {
                        borderColor = Colors.blueAccent;
                      } else {
                        borderColor = Colors.green;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                          border: Border(
                            left: BorderSide(color: borderColor, width: 5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// 🔹 File Icon
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: borderColor.withOpacity(0.1),
                                child: Icon(
                                  Icons.description,
                                  color: borderColor,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 14),

                              /// 🔹 File Info + Actions
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// File name
                                    Text(
                                      file["name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    /// Upload date
                                    Text(
                                      "Uploaded on: ${file["date"]}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    /// 🔹 Action buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildActionButton(
                                          icon: Icons.visibility,
                                          color: AppColors.primary,
                                          onTap: () =>
                                              _previewFile(file["path"]),
                                        ),
                                        const SizedBox(width: 8),
                                        _buildActionButton(
                                          icon: Icons.download,
                                          color: Colors.green,
                                          onTap: () => _downloadFile(
                                              file["path"], file["name"]),
                                        ),
                                        const SizedBox(width: 8),
                                        _buildActionButton(
                                          icon: Icons.delete,
                                          color: Colors.red,
                                          onTap: () => _deleteFile(index),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
