import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/others/notiofication/NotificationDetailScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class RespondentNotificationScreen extends StatelessWidget {
  const RespondentNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "Case Update",
        "message": "Case #2024-45 has been updated by the claimant.",
        "date": "20 Sep 2025",
        "icon": Icons.gavel,
        "color": Colors.blue,
      },
      {
        "title": "Payment Reminder",
        "message": "Your payment of ₹1,200 for Case #2024-52 is pending.",
        "date": "18 Sep 2025",
        "icon": Icons.payment,
        "color": Colors.redAccent,
      },
      {
        "title": "Hearing Scheduled",
        "message":
            "Virtual hearing for Case #2024-45 is fixed for 25 Sep 2025.",
        "date": "15 Sep 2025",
        "icon": Icons.video_call,
        "color": Colors.green,
      },
      {
        "title": "Document Uploaded",
        "message": "A new document has been uploaded by the neutral.",
        "date": "12 Sep 2025",
        "icon": Icons.insert_drive_file,
        "color": Colors.orange,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Dismissible(
            key: Key(notification["title"]),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${notification["title"]} dismissed")),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.92),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        notification["color"].withOpacity(0.7),
                        notification["color"]
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification["icon"],
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                title: Text(
                  notification["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      notification["message"],
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          notification["date"],
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: notification["color"].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "View",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NotificationDetailScreen(
                        title: notification["title"],
                        message: notification["message"],
                        date: notification["date"],
                        icon: notification["icon"],
                        color: notification["color"],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
