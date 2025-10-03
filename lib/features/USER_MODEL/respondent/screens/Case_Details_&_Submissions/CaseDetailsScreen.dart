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
        backgroundColor: AppColors.successGreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Case Details"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔹 Case Information Card
            Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: theme.dividerColor),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Case ID: C-101",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("Claimant: Amit Sharma",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    Text("Respondent: Priya Singh",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    Text("Filed On: 12 Sep 2025",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    Text("Status: Under Review",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.accentOrange,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// 🔹 Submissions Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Submissions",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// 🔹 Submissions List
            Expanded(
              child: submissions.isEmpty
                  ? Center(
                      child: Text(
                        "No submissions yet.",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: submissions.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: theme.dividerColor),
                      itemBuilder: (context, index) {
                        final sub = submissions[index];
                        return Card(
                          color: theme.cardColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: theme.dividerColor),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.15),
                              child: const Icon(Icons.description,
                                  color: AppColors.primary),
                            ),
                            title: Text(
                              sub["title"]!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              "By: ${sub["submittedBy"]}\nDate: ${sub["date"]}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
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

            /// 🔹 Upload Response Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Response"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonTextLight,
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
