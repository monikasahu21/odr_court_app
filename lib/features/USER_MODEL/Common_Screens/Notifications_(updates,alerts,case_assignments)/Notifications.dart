import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

/// Data model for notifications
class NotificationItem {
  final String title;
  final String message;
  final String type; // update, alert, case
  final DateTime dateTime;

  NotificationItem({
    required this.title,
    required this.message,
    required this.type,
    required this.dateTime,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = "All";

  // ✅ Dummy notifications
  final List<NotificationItem> allNotifications = [
    NotificationItem(
      title: "New Case Assigned",
      message: "Case #1023 has been assigned to you.",
      type: "case",
      dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationItem(
      title: "System Update",
      message: "The hearing module was upgraded.",
      type: "update",
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      title: "Payment Alert",
      message: "Respondent has completed the payment for Case #1001.",
      type: "alert",
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationItem(
      title: "Old Notification",
      message: "This is from last week.",
      type: "update",
      dateTime: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ✅ Apply filter
    final filtered = selectedFilter == "All"
        ? allNotifications
        : allNotifications
            .where((n) => n.type == selectedFilter.toLowerCase())
            .toList();

    // ✅ Group notifications
    final today = filtered.where((n) {
      final now = DateTime.now();
      return n.dateTime.day == now.day &&
          n.dateTime.month == now.month &&
          n.dateTime.year == now.year;
    }).toList();

    final yesterday = filtered.where((n) {
      final y = DateTime.now().subtract(const Duration(days: 1));
      return n.dateTime.day == y.day &&
          n.dateTime.month == y.month &&
          n.dateTime.year == y.year;
    }).toList();

    final earlier = filtered
        .where((n) => n.dateTime
            .isBefore(DateTime.now().subtract(const Duration(days: 1))))
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildFilterBar(theme),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (today.isNotEmpty) _buildSection("Today", today, theme),
                if (yesterday.isNotEmpty)
                  _buildSection("Yesterday", yesterday, theme),
                if (earlier.isNotEmpty)
                  _buildSection("Earlier", earlier, theme),
                if (today.isEmpty && yesterday.isEmpty && earlier.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        "No notifications available",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Filter bar with ChoiceChips
  Widget _buildFilterBar(ThemeData theme) {
    final filters = ["All", "Alert", "Case", "Update"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                selectedColor: AppColors.accentOrange,
                backgroundColor: theme.cardColor,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.darkTextPrimary
                      : AppColors.primary,
                ),
                onSelected: (_) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// 🔹 Section builder
  Widget _buildSection(
      String title, List<NotificationItem> items, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? AppColors.darkTextPrimary
                  : AppColors.textPrimary,
            ),
          ),
        ),
        ...items.map((item) => _buildNotificationCard(item, theme)).toList(),
      ],
    );
  }

  /// 🔹 Notification card UI
  Widget _buildNotificationCard(NotificationItem item, ThemeData theme) {
    return Card(
      color: theme.cardColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getIconBackground(item.type),
          child: Icon(
            _getIcon(item.type),
            color: AppColors.buttonTextLight,
          ),
        ),
        title: Text(
          item.title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.primary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? AppColors.darkTextPrimary
                  : AppColors.primary,
            ),
          ),
        ),
        trailing: Text(
          _formatTime(item.dateTime),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.primary,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NotificationDetailScreen(notification: item),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Helpers
  IconData _getIcon(String type) {
    switch (type) {
      case "alert":
        return Icons.warning_amber_rounded;
      case "case":
        return Icons.gavel;
      case "update":
        return Icons.system_update;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconBackground(String type) {
    switch (type) {
      case "alert":
        return AppColors.errorRed;
      case "case":
        return AppColors.primary;
      case "update":
        return AppColors.successGreen;
      default:
        return AppColors.iconDefault;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }
}

/// 🔹 Detail Screen for Notification
class NotificationDetailScreen extends StatelessWidget {
  final NotificationItem notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          notification.title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppColors.darkTextPrimary
                : AppColors.primary,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          color: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: const Icon(Icons.notifications,
                          color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        notification.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.brightness == Brightness.dark
                              ? AppColors.darkTextPrimary
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  notification.message,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Type: ${notification.type.toUpperCase()}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Received: ${notification.dateTime}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.brightness == Brightness.dark
                        ? AppColors.darkTextPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
