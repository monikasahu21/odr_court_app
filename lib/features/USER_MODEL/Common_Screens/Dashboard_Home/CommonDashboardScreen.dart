import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Dashboard_Home/NotificationDetailScreen.dart';
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 Welcome Banner
              _buildWelcomeBanner(context, userName, role),
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
                  return InkWell(
                    onTap: () {
                      // TODO: Add navigation logic per role
                    },
                    child: _buildStatCard(
                      context,
                      stat['title']!,
                      stat['count']!,
                      stat['icon'] as IconData,
                      stat['color'] as Color,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // 🔹 Upcoming Hearings
              Text(
                "📅 Upcoming Hearings",
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _buildHearingTile(
                context,
                "Case #2024-45",
                "25 Sep 2025",
                "10:30 AM",
                "Virtual Courtroom",
              ),
              _buildHearingTile(
                context,
                "Case #2024-52",
                "28 Sep 2025",
                "2:00 PM",
                "District Court - Room 3",
              ),
              const SizedBox(height: 24),

              // 🔹 Notifications
              Text(
                "🔔 Recent Notifications",
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              for (var notification in notifications)
                _buildNotificationTile(context, notification),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Welcome Banner
  Widget _buildWelcomeBanner(
      BuildContext context, String userName, String role) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accentOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.dashboard_rounded,
              color: AppColors.buttonTextLight,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, $userName 👋",
                  style: textTheme.titleLarge?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.buttonTextLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$role Dashboard",
                  style: textTheme.bodyMedium?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary.withOpacity(0.7)
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Stat Card
  Widget _buildStatCard(BuildContext context, String title, String count,
      IconData icon, Color color) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.cardColor,
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
          Text(
            count,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? AppColors.darkTextPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Hearing Tile
  Widget _buildHearingTile(BuildContext context, String caseId, String date,
      String time, String venue) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: const Icon(
          Icons.gavel,
          color: AppColors.accentOrange,
          size: 32,
        ),
        title: Text(
          caseId,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          "$date • $time\n$venue",
          style: textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary.withOpacity(0.7)
                : AppColors.textSecondary,
          ),
          maxLines: 2,
        ),
        isThreeLine: true,
      ),
    );
  }

  /// 🔹 Notification Tile
  Widget _buildNotificationTile(
      BuildContext context, Map<String, String> notification) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.notifications, color: Colors.white),
        ),
        title: Text(
          notification["title"]!,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          "${notification["caseId"]} • ${notification["date"]}",
          style: textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary.withOpacity(0.7)
                : AppColors.textSecondary,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NotificationDetailScreen(notification: notification),
            ),
          );
        },
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
        "date": "20 Sep 2025"
      },
      {
        "title": "Order uploaded",
        "caseId": "Case #2024-50",
        "date": "18 Sep 2025"
      },
    ];
  }
}
