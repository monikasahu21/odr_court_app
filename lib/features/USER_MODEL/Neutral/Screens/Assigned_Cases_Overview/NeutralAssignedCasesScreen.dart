import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/Neutral/Screens/Assigned_Cases_Overview/NeutralCaseDetailScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NeutralAssignedCasesScreen extends StatelessWidget {
  const NeutralAssignedCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> assignedCases = [
      {
        "caseId": "CASE-2025-001",
        "title": "Rahul Sharma vs Meera Singh",
        "status": "Ongoing",
        "dateAssigned": "20 Sep 2025",
      },
      {
        "caseId": "CASE-2025-002",
        "title": "Anil Kumar vs State Bank",
        "status": "Pending Hearing",
        "dateAssigned": "18 Sep 2025",
      },
      {
        "caseId": "CASE-2025-003",
        "title": "Sunita Devi vs Mahesh Gupta",
        "status": "Closed",
        "dateAssigned": "10 Sep 2025",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Cases List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: assignedCases.length,
                itemBuilder: (context, index) {
                  final caseData = assignedCases[index];
                  final status = caseData["status"];

                  // Pick color based on status
                  Color statusColor;
                  if (status == "Closed") {
                    statusColor = Colors.red;
                  } else if (status == "Ongoing") {
                    statusColor = Colors.green;
                  } else {
                    statusColor = AppColors.accentOrange;
                  }

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Case Title + Status Chip
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  caseData["title"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              Chip(
                                label: Text(
                                  status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: statusColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Case ID
                          Text(
                            "Case ID: ${caseData["caseId"]}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Assigned Date
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 6),
                              Text(
                                "Assigned: ${caseData["dateAssigned"]}",
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Action Button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.buttonBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NeutralCaseDetailScreen(
                                      caseData: caseData,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.open_in_new, size: 18),
                              label: const Text("View Details"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
