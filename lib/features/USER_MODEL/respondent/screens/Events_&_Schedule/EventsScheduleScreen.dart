import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class EventsScheduleScreen extends StatefulWidget {
  const EventsScheduleScreen({super.key});

  @override
  State<EventsScheduleScreen> createState() => _EventsScheduleScreenState();
}

class _EventsScheduleScreenState extends State<EventsScheduleScreen> {
  List<Map<String, String>> events = [
    {
      "title": "Case C-201 Hearing",
      "date": "30 Sep 2025",
      "time": "10:30 AM",
      "type": "Hearing",
      "status": "Upcoming",
    },
    {
      "title": "Mediation Meeting - Case C-199",
      "date": "27 Sep 2025",
      "time": "2:00 PM",
      "type": "Meeting",
      "status": "Upcoming",
    },
    {
      "title": "Case C-198 Hearing",
      "date": "20 Sep 2025",
      "time": "3:00 PM",
      "type": "Hearing",
      "status": "Completed",
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case "Upcoming":
        return AppColors.primary;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.redAccent;
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
        itemCount: events.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.divider),
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            color: AppColors.cardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.divider),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: Icon(
                event["type"] == "Hearing" ? Icons.gavel : Icons.people,
                color: AppColors.iconDefault,
              ),
              title: Text(
                event["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    "Date: ${event["date"]} | Time: ${event["time"]}",
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  Text(
                    "Type: ${event["type"]}",
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  Text(
                    "Status: ${event["status"]}",
                    style: TextStyle(
                      color: _statusColor(event["status"]!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: event["status"] == "Upcoming"
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "View",
                        style: TextStyle(color: AppColors.buttonTextLight),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Opening details for ${event["title"]}..."),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
