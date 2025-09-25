import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Documents_Workspace/DocumentPreviewScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentWorkspaceScreen extends StatefulWidget {
  const DocumentWorkspaceScreen({super.key});

  @override
  State<DocumentWorkspaceScreen> createState() =>
      _DocumentWorkspaceScreenState();
}

class _DocumentWorkspaceScreenState extends State<DocumentWorkspaceScreen> {
  List<Map<String, String>> _documents = [];
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _loadDocuments(); // load saved docs when screen starts
  }

  /// Load saved docs from SharedPreferences
  Future<void> _loadDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDocs = prefs.getStringList("respondent_documents") ?? [];

    setState(() {
      _documents = storedDocs
          .map((doc) => Map<String, String>.from(jsonDecode(doc)))
          .toList();
    });

    // if no saved docs, load defaults
    if (_documents.isEmpty) {
      _documents = [
        {
          "title": "Claimant Petition",
          "caseId": "Case #2024-45",
          "date": "10 Sep 2025",
          "file": "petition.pdf",
          "url":
              "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
        },
        {
          "title": "Respondent Reply",
          "caseId": "Case #2024-45",
          "date": "15 Sep 2025",
          "file": "reply.pdf",
          "url":
              "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
        },
      ];
      _saveDocuments();
    }
  }

  /// Save docs to SharedPreferences
  Future<void> _saveDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedDocs = _documents.map((doc) => jsonEncode(doc)).toList();
    await prefs.setStringList("respondent_documents", encodedDocs);
  }

  /// Pick document from gallery
  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _documents.add({
          "title": "Supporting Document",
          "caseId": "Case #2024-45",
          "date":
              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
          "file": pickedFile.name,
          "url": pickedFile.path,
        });
      });

      await _saveDocuments(); // persist new list

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploaded: ${pickedFile.name}")),
      );
    }
  }

  /// Download file using Dio
  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = "${dir.path}/$fileName";

      await Dio().download(url, savePath);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("File saved to $savePath")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Download failed: $e")),
      );
    }
  }

  /// Delete document
  Future<void> _deleteDocument(int index) async {
    final docName = _documents[index]["file"]!;
    setState(() {
      _documents.removeAt(index);
    });
    await _saveDocuments();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$docName deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        onPressed: _pickFile,
        icon: const Icon(Icons.upload_file),
        label: const Text("Upload"),
      ),
      body: _documents.isEmpty
          ? const Center(
              child: Text(
                "No documents uploaded yet",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: _documents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final doc = _documents[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Document Icon
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.insert_drive_file,
                                color: AppColors.primary, size: 32),
                          ),
                          const SizedBox(height: 12),

                          // Title & Case Info
                          Text(
                            doc["title"]!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textPrimary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${doc["caseId"]}\n${doc["date"]}",
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),

                          // Actions row
                          // Actions row
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly, // spread evenly
                            children: [
                              Flexible(
                                child: IconButton(
                                  icon: const Icon(Icons.visibility,
                                      color: AppColors.accentOrange),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DocumentPreviewScreen(
                                          filePath: doc["url"]!,
                                          fileName: doc["file"]!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: const Icon(Icons.download,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    _downloadFile(doc["url"]!, doc["file"]!);
                                  },
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    _deleteDocument(index);
                                  },
                                ),
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
}
