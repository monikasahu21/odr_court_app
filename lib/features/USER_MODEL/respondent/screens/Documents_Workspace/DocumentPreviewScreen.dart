import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final String filePath;
  final String fileName;

  const DocumentPreviewScreen(
      {super.key, required this.filePath, required this.fileName});

  @override
  Widget build(BuildContext context) {
    final isPDF = filePath.toLowerCase().endsWith(".pdf");

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.accentOrange,
        title: Text(fileName,
            style: const TextStyle(color: AppColors.buttonTextLight)),
      ),
      body: Center(
        child: isPDF
            ? PDFView(
                filePath: filePath,
              )
            : Image.file(File(filePath)),
      ),
    );
  }
}
