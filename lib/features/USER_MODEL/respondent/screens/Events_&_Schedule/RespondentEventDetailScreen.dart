import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/model/respondentEvent.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class RespondentEventDetailScreen extends StatelessWidget {
  final EventModel event;
  const RespondentEventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // debug print to confirm contents (remove in production)
    // print('EventDetailScreen received: ${event.title}, ${event.date}');

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: AppColors.accentOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      child:
                          Icon(event.icon, size: 28, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      event.date,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                // extra details (placeholder)
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Details & attachments',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  'No attachments in this demo. In production show a list of files or notes.',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
