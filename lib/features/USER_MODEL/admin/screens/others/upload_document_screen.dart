import 'package:flutter/material.dart';

class UploadDocumentScreen extends StatelessWidget {
  const UploadDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents Workspace')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Secure Document Workspace (placeholder)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('Agreement.pdf'),
                subtitle: const Text('Uploaded by Claimant A'),
                trailing: ElevatedButton(onPressed: () {}, child: const Text('Download')),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder: integrate file picker or upload API
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload flow not implemented in starter scaffold')));
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload document'),
            ),
          ],
        ),
      ),
    );
  }
}
