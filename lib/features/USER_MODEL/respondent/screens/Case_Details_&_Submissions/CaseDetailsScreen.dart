import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CaseDetailsScreen extends StatefulWidget {
  const CaseDetailsScreen({super.key});

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  List<Map<String, String>> submissions = [
    {
      "submittedBy": "Claimant (Amit Sharma)",
      "title": "Initial Petition",
      "date": "12 Sep 2025",
      "file": "petition_doc.pdf"
    },
    {
      "submittedBy": "Respondent (Priya Singh)",
      "title": "Preliminary Response",
      "date": "15 Sep 2025",
      "file": "response_doc.pdf"
    },
  ];

  void _uploadResponse() {
    setState(() {
      submissions.add({
        "submittedBy": "Respondent (Priya Singh)",
        "title": "Additional Response",
        "date": "25 Sep 2025",
        "file": "additional_response.pdf",
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Response uploaded successfully"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Case Information Card
            Card(
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.divider),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Case ID: C-101",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text("Claimant: Amit Sharma",
                        style: TextStyle(color: AppColors.textSecondary)),
                    Text("Respondent: Priya Singh",
                        style: TextStyle(color: AppColors.textSecondary)),
                    Text("Filed On: 12 Sep 2025",
                        style: TextStyle(color: AppColors.textSecondary)),
                    Text("Status: Under Review",
                        style: TextStyle(color: AppColors.accentOrange)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Submissions Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Submissions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Submissions List
            Expanded(
              child: submissions.isEmpty
                  ? const Center(
                      child: Text(
                        "No submissions yet.",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.separated(
                      itemCount: submissions.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: AppColors.divider),
                      itemBuilder: (context, index) {
                        final sub = submissions[index];
                        return Card(
                          color: AppColors.cardBackground,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: AppColors.divider),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.description,
                                color: AppColors.iconDefault),
                            title: Text(
                              sub["title"]!,
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "By: ${sub["submittedBy"]}\nDate: ${sub["date"]}",
                              style: const TextStyle(
                                  color: AppColors.textSecondary),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.download,
                                  color: AppColors.primary),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Downloading ${sub["file"]}..."),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            // 🔹 Upload Response Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file,
                    color: AppColors.buttonTextLight),
                label: const Text(
                  "Upload Response",
                  style: TextStyle(color: AppColors.buttonTextLight),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _uploadResponse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
