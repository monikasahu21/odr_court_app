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

  /// 🔹 Status colors mapped with AppColors
  Color _statusColor(String status) {
    switch (status) {
      case "Upcoming":
        return AppColors.primary;
      case "Completed":
        return AppColors.successGreen;
      case "Cancelled":
        return AppColors.errorRed;
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
        title: const Text("Events Schedule"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        elevation: 2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            elevation: 3,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Icon(
                  event["type"] == "Hearing" ? Icons.gavel : Icons.people,
                  color: AppColors.primary,
                ),
              ),
              title: Text(
                event["title"]!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${event["date"]} | Time: ${event["time"]}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "Type: ${event["type"]}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "Status: ${event["status"]}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _statusColor(event["status"]!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: event["status"] == "Upcoming"
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.buttonTextLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("View"),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Opening details for ${event["title"]}..."),
                            backgroundColor: AppColors.accentOrange,
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
