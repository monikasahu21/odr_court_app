import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

/// Common Dashboard Screen for Admin, Claimant, Respondent, Neutral
class CommonDashboardScreen extends StatelessWidget {
  final String userName;
  final String role;

  const CommonDashboardScreen({
    super.key,
    required this.userName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final stats = _getStatsForRole(role);
    final notifications = _getNotificationsForRole(role);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.accentOrange,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.dashboard, color: Colors.white, size: 36),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome, $userName 👋",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "$role Dashboard",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 Quick Stats Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 120,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return _buildStatCard(
                    stat['title']!,
                    stat['count']!,
                    stat['icon'] as IconData,
                    stat['color'] as Color,
                  );
                },
              ),
              const SizedBox(height: 24),

              // 🔹 Upcoming Hearings
              const Text(
                "📅 Upcoming Hearings",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _buildHearingTile("Case #2024-45", "25 Sep 2025", "10:30 AM",
                  "Virtual Courtroom"),
              _buildHearingTile("Case #2024-52", "28 Sep 2025", "2:00 PM",
                  "District Court - Room 3"),
              const SizedBox(height: 24),

              // 🔹 Notifications
              const Text(
                "🔔 Recent Notifications",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              for (var notification in notifications)
                _buildNotificationTile(notification),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Stat Card
  Widget _buildStatCard(
      String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 5),
          Text(count,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 5),
          Text(title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  /// 🔹 Hearing Tile
  Widget _buildHearingTile(
      String caseId, String date, String time, String venue) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading:
            const Icon(Icons.gavel, color: AppColors.accentOrange, size: 32),
        title: Text(caseId,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        subtitle: Text("$date • $time\n$venue",
            style: const TextStyle(color: AppColors.textSecondary)),
        isThreeLine: true,
      ),
    );
  }

  /// 🔹 Notification Tile
  Widget _buildNotificationTile(Map<String, String> notification) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(notification["title"]!,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        subtitle: Text(
          "${notification["caseId"]} • ${notification["date"]}",
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }

  /// 🔹 Role-specific stats
  List<Map<String, dynamic>> _getStatsForRole(String role) {
    switch (role.toLowerCase()) {
      case "admin":
        return [
          {
            "title": "Users",
            "count": "120",
            "icon": Icons.people,
            "color": AppColors.primary
          },
          {
            "title": "Cases",
            "count": "85",
            "icon": Icons.folder,
            "color": AppColors.accentOrange
          },
          {
            "title": "Hearings",
            "count": "15",
            "icon": Icons.event,
            "color": Colors.green
          },
        ];
      case "claimant":
        return [
          {
            "title": "Filed Cases",
            "count": "7",
            "icon": Icons.note_add,
            "color": AppColors.primary
          },
          {
            "title": "Pending",
            "count": "3",
            "icon": Icons.pending_actions,
            "color": AppColors.accentOrange
          },
          {
            "title": "Closed",
            "count": "4",
            "icon": Icons.done_all,
            "color": Colors.green
          },
        ];
      case "neutral":
        return [
          {
            "title": "Assigned",
            "count": "10",
            "icon": Icons.assignment_ind,
            "color": AppColors.primary
          },
          {
            "title": "Orders Given",
            "count": "6",
            "icon": Icons.gavel,
            "color": Colors.green
          },
          {
            "title": "Hearings",
            "count": "2",
            "icon": Icons.event_available,
            "color": AppColors.accentOrange
          },
        ];
      default: // respondent
        return [
          {
            "title": "Pending Cases",
            "count": "5",
            "icon": Icons.pending_actions,
            "color": AppColors.accentOrange
          },
          {
            "title": "Closed Cases",
            "count": "12",
            "icon": Icons.done_all,
            "color": Colors.green
          },
          {
            "title": "Hearings",
            "count": "2",
            "icon": Icons.event,
            "color": AppColors.primary
          },
        ];
    }
  }

  /// 🔹 Notifications
  List<Map<String, String>> _getNotificationsForRole(String role) {
    return [
      {
        "title": "New submission received",
        "caseId": "Case #2024-45",
        "date": "20 Sep 2025",
      },
      {
        "title": "Order uploaded",
        "caseId": "Case #2024-50",
        "date": "18 Sep 2025",
      },
    ];
  }
}
