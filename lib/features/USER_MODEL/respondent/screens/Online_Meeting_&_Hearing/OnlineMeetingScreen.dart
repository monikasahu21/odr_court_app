import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class OnlineMeetingScreen extends StatefulWidget {
  const OnlineMeetingScreen({super.key});

  @override
  State<OnlineMeetingScreen> createState() => _OnlineMeetingScreenState();
}

class _OnlineMeetingScreenState extends State<OnlineMeetingScreen> {
  List<Map<String, String>> hearings = [
    {
      "caseId": "C-201",
      "date": "30 Sep 2025",
      "time": "10:30 AM",
      "judge": "Justice Suresh Menon",
      "status": "Scheduled",
    },
    {
      "caseId": "C-198",
      "date": "20 Sep 2025",
      "time": "3:00 PM",
      "judge": "Justice Kavita Reddy",
      "status": "Completed",
    },
  ];

  void _joinMeeting(String caseId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Joining online meeting for Case $caseId..."),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  /// 🔹 Map status to theme colors
  Color _statusColor(String status) {
    switch (status) {
      case "Scheduled":
        return AppColors.primary;
      case "Completed":
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
        title: const Text("Online Hearings"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        elevation: 2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hearings.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final hearing = hearings[index];
          return Card(
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
                  // 🔹 Case ID
                  Text(
                    "Case: ${hearing["caseId"]}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 🔹 Hearing Info
                  Text("Date: ${hearing["date"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Time: ${hearing["time"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Judge: ${hearing["judge"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),

                  const SizedBox(height: 10),

                  // 🔹 Status + Join Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: ${hearing["status"]}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _statusColor(hearing["status"]!),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.video_call,
                            color: AppColors.buttonTextLight),
                        label: const Text(
                          "Join Now",
                          style: TextStyle(color: AppColors.buttonTextLight),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: hearing["status"] == "Scheduled"
                            ? () => _joinMeeting(hearing["caseId"]!)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
