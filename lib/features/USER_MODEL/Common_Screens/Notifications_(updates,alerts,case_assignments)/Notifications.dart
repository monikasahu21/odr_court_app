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
    // ✅ Apply filter
    final filtered = selectedFilter == "All"
        ? allNotifications
        : allNotifications
            .where((n) => n.type == selectedFilter.toLowerCase())
            .toList();

    // ✅ Group notifications into Today, Yesterday, Earlier
    final today = filtered
        .where((n) =>
            n.dateTime.day == DateTime.now().day &&
            n.dateTime.month == DateTime.now().month &&
            n.dateTime.year == DateTime.now().year)
        .toList();

    final yesterday = filtered
        .where((n) =>
            n.dateTime.day ==
                DateTime.now().subtract(const Duration(days: 1)).day &&
            n.dateTime.month ==
                DateTime.now().subtract(const Duration(days: 1)).month &&
            n.dateTime.year ==
                DateTime.now().subtract(const Duration(days: 1)).year)
        .toList();

    final earlier = filtered
        .where((n) => n.dateTime
            .isBefore(DateTime.now().subtract(const Duration(days: 1))))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (today.isNotEmpty) _buildSection("Today", today),
                if (yesterday.isNotEmpty) _buildSection("Yesterday", yesterday),
                if (earlier.isNotEmpty) _buildSection("Earlier", earlier),
                if (today.isEmpty && yesterday.isEmpty && earlier.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(
                        "No notifications available",
                        style: TextStyle(color: AppColors.textSecondary),
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
  Widget _buildFilterBar() {
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
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppColors.buttonTextLight
                      : AppColors.textPrimary,
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

  /// 🔹 Section builder (e.g., Today, Yesterday, Earlier)
  Widget _buildSection(String title, List<NotificationItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        ...items.map((item) => _buildNotificationCard(item)).toList(),
      ],
    );
  }

  /// 🔹 Notification card UI
  Widget _buildNotificationCard(NotificationItem item) {
    return Card(
      color: AppColors.cardBackground,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: _getIconBackground(item.type),
          child: Icon(
            _getIcon(item.type),
            color: Colors.white,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.message,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        trailing: Text(
          _formatTime(item.dateTime),
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        onTap: () {
          // 👉 Handle tap (e.g., navigate to case details)
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
        return Colors.redAccent;
      case "case":
        return AppColors.primary;
      case "update":
        return Colors.green;
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
