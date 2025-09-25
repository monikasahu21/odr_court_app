import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/model/respondentEvent.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Events_&_Schedule/RespondentEventDetailScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class RespondentEventScreen extends StatelessWidget {
  const RespondentEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // build a strongly typed list
    final List<EventModel> events = [
      EventModel.fromMap({
        "title": "Case Filed",
        "description": "Case #2024-45 filed by claimant",
        "date": "01 Sep 2025",
        "icon": Icons.description,
      }),
      EventModel.fromMap({
        "title": "Reply Submitted",
        "description": "Respondent submitted written reply",
        "date": "05 Sep 2025",
        "icon": Icons.mail,
      }),
      EventModel.fromMap({
        "title": "Hearing Scheduled",
        "description": "Virtual hearing fixed for 25 Sep 2025",
        "date": "10 Sep 2025",
        "icon": Icons.video_call,
      }),
      EventModel.fromMap({
        "title": "Document Uploaded",
        "description": "Order uploaded by neutral",
        "date": "18 Sep 2025",
        "icon": Icons.upload_file,
      }),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final isLast = index == events.length - 1;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // timeline indicator
              Column(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accentOrange, AppColors.primary],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(event.icon, size: 16, color: Colors.white),
                  ),
                  if (!isLast)
                    Container(
                      width: 3,
                      height: 80,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accentOrange.withOpacity(0.7),
                            AppColors.primary.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Event card (tap -> detail)
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    // pass the typed model directly
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RespondentEventDetailScreen(event: event),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          event.description,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.textSecondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 14, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              event.date,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
