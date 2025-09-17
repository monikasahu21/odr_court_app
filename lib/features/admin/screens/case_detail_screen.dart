import 'package:flutter/material.dart';
import 'package:odr_court_app/features/admin/models/case_model.dart';

class CaseDetailScreen extends StatelessWidget {
  const CaseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final CaseModel? c = args is CaseModel ? args : null;

    return Scaffold(
      appBar: AppBar(title: Text(c?.title ?? 'Case detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Case ID: ${c?.id ?? 'N/A'}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Status: ${c?.status ?? 'N/A'}'),
            const SizedBox(height: 12),
            Text('Summary',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(c?.summary ?? 'No summary available.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/upload'),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload/View Documents'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/schedule'),
              icon: const Icon(Icons.schedule),
              label: const Text('Schedule Hearing / Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
