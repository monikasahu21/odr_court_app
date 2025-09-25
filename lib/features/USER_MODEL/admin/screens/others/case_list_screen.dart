import 'package:flutter/material.dart';
import 'package:odr_court_app/features/admin/models/case_model.dart';
import 'package:odr_court_app/features/admin/services/mock_service.dart';

class CaseListScreen extends StatelessWidget {
  const CaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CaseModel> cases = MockService.fetchCases();
    return Scaffold(
      appBar: AppBar(title: const Text('Cases')),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final c = cases[index];
          return ListTile(
            leading: CircleAvatar(child: Text(c.id.split('-').last)),
            title: Text(c.title),
            subtitle: Text('${c.status} • ${c.createdBy}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/caseDetail', arguments: c);
            },
          );
        },
      ),
    );
  }
}
