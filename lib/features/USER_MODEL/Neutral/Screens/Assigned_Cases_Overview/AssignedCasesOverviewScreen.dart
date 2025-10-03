import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class AssignedCasesOverviewScreen extends StatefulWidget {
  const AssignedCasesOverviewScreen({super.key});

  @override
  State<AssignedCasesOverviewScreen> createState() =>
      _AssignedCasesOverviewScreenState();
}

class _AssignedCasesOverviewScreenState
    extends State<AssignedCasesOverviewScreen> {
  List<Map<String, String>> assignedCases = [
    {
      "caseId": "C-301",
      "title": "Property Boundary Dispute",
      "claimant": "Amit Sharma",
      "respondent": "Rahul Verma",
      "status": "Under Review",
      "nextHearing": "30 Sep 2025, 10:30 AM",
    },
    {
      "caseId": "C-302",
      "title": "Unpaid Salary Case",
      "claimant": "Priya Singh",
      "respondent": "Ravi Kumar",
      "status": "Hearing Scheduled",
      "nextHearing": "02 Oct 2025, 2:00 PM",
    },
    {
      "caseId": "C-295",
      "title": "Business Contract Dispute",
      "claimant": "Neha Gupta",
      "respondent": "Anil Mehta",
      "status": "Resolved",
      "nextHearing": "-",
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case "Under Review":
        return AppColors.accentOrange;
      case "Hearing Scheduled":
        return AppColors.primary;
      case "Resolved":
        return AppColors.successGreen;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Assigned Cases Overview",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: assignedCases.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final caseData = assignedCases[index];
          return Card(
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Case Title & ID
                  Text(
                    "${caseData["caseId"]} - ${caseData["title"]}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// Claimant & Respondent
                  Text(
                    "Claimant: ${caseData["claimant"]}",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  Text(
                    "Respondent: ${caseData["respondent"]}",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),

                  /// Status & Hearing
                  Text(
                    "Status: ${caseData["status"]}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: _statusColor(caseData["status"]!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Next Hearing: ${caseData["nextHearing"]}",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 12),

                  /// Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.visibility,
                            color: AppColors.primary),
                        label: Text(
                          "View Details",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Opening details for ${caseData["caseId"]}..."),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      if (caseData["status"] != "Resolved")
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentOrange,
                            foregroundColor: AppColors.buttonTextLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Updating progress for ${caseData["caseId"]}..."),
                                backgroundColor: AppColors.accentOrange,
                              ),
                            );
                          },
                          child: Text(
                            "Update Progress",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.buttonTextLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
