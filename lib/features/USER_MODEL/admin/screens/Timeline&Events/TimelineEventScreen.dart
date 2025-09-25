import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Timeline&Events/EventDetailScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class AdminTimelineEventScreen extends StatelessWidget {
  const AdminTimelineEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {
        "title": "New User Registered",
        "description": "Ravi Sharma created an account.",
        "time": "09:30 AM",
        "icon": Icons.person_add,
        "color": Colors.blue,
      },
      {
        "title": "New Case Added",
        "description": "Case #12345 was submitted by Advocate Meera.",
        "time": "10:15 AM",
        "icon": Icons.folder_copy,
        "color": Colors.orange,
      },
      {
        "title": "Document Uploaded",
        "description": "Sunita uploaded supporting documents for Case #12345.",
        "time": "11:00 AM",
        "icon": Icons.insert_drive_file,
        "color": Colors.green,
      },
      {
        "title": "Report Generated",
        "description": "Monthly case report generated successfully.",
        "time": "01:45 PM",
        "icon": Icons.bar_chart,
        "color": Colors.purple,
      },
      {
        "title": "Admin Settings Updated",
        "description": "System settings were updated by Admin.",
        "time": "03:20 PM",
        "icon": Icons.settings,
        "color": Colors.redAccent,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 🔹 Continuous Timeline Line
          Positioned.fill(
            left: 40,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: 2,
            ),
          ),

          // 🔹 Events List
          ListView.separated(
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final event = events[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Dot
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          event["color"].withOpacity(0.8),
                          event["color"],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: event["color"].withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(event["icon"], color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 16),

                  // Event Card (Clickable)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        // 🔹 Navigate to details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: event),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border(
                            left: BorderSide(
                              color: event["color"],
                              width: 5,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event["title"],
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary)),
                            const SizedBox(height: 6),
                            Text(event["description"],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary)),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.access_time,
                                    size: 14, color: Colors.grey.shade600),
                                const SizedBox(width: 4),
                                Text(
                                  event["time"],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
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
        ],
      ),
    );
  }
}
