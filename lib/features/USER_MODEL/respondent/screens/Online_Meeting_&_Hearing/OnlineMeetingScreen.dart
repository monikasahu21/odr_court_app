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

  Color _statusColor(String status) {
    switch (status) {
      case "Scheduled":
        return AppColors.primary;
      case "Completed":
        return Colors.green;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hearings.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.divider),
        itemBuilder: (context, index) {
          final hearing = hearings[index];
          return Card(
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
                children: [
                  Text(
                    "Case: ${hearing["caseId"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Date: ${hearing["date"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Time: ${hearing["time"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Judge: ${hearing["judge"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: ${hearing["status"]}",
                        style: TextStyle(
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
