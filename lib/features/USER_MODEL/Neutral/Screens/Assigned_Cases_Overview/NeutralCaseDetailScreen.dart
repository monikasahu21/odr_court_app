import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NeutralCaseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> caseData;

  const NeutralCaseDetailScreen({super.key, required this.caseData});

  @override
  Widget build(BuildContext context) {
    final status = caseData["status"];

    Color statusColor;
    if (status == "Closed") {
      statusColor = Colors.red;
    } else if (status == "Ongoing") {
      statusColor = Colors.green;
    } else {
      statusColor = AppColors.accentOrange;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Case Details"),
        backgroundColor: AppColors.accentOrange,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Case Title
                Text(
                  caseData["title"],
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary),
                ),
                const SizedBox(height: 8),

                // Case ID
                Text("Case ID: ${caseData["caseId"]}",
                    style: const TextStyle(color: AppColors.textSecondary)),

                const SizedBox(height: 12),

                // Status
                Chip(
                  label: Text(status),
                  backgroundColor: statusColor,
                  labelStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // Date Assigned
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: AppColors.textSecondary, size: 18),
                    const SizedBox(width: 8),
                    Text("Assigned on: ${caseData["dateAssigned"]}",
                        style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 16),

                // Description
                const Text(
                  "Case Description:",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  caseData["description"] ?? "No details available.",
                  style: const TextStyle(color: AppColors.textSecondary),
                ),

                const Spacer(),

                // Action button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("Taking action on ${caseData["caseId"]}"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      textStyle: TextStyle(color: AppColors.buttonTextLight),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text(
                      "Take Action",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
