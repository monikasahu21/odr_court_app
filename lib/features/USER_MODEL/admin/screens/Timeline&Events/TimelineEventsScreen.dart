import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class TimelineEventsScreen extends StatefulWidget {
  const TimelineEventsScreen({super.key});

  @override
  State<TimelineEventsScreen> createState() => _TimelineEventsScreenState();
}

class _TimelineEventsScreenState extends State<TimelineEventsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 🔹 Dummy timeline events (replace with DB/API later)
  List<Map<String, dynamic>> events = [
    {
      "title": "Case C-1001 Filed",
      "description": "Ravi Kumar filed a petition against Neha Gupta.",
      "date": "25-Sep-2025 10:30 AM",
      "type": "Case"
    },
    {
      "title": "Document Uploaded",
      "description": "Neha Gupta submitted Evidence_1.jpg for Case C-1002.",
      "date": "24-Sep-2025 03:15 PM",
      "type": "Document"
    },
    {
      "title": "Case Hearing Scheduled",
      "description": "Hearing for Case C-1003 scheduled by Justice Rao.",
      "date": "23-Sep-2025 11:00 AM",
      "type": "Event"
    },
    {
      "title": "User Registered",
      "description": "Anjali Verma registered as Respondent.",
      "date": "22-Sep-2025 09:45 AM",
      "type": "User"
    },
  ];

  List<Map<String, dynamic>> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
    _searchController.addListener(_filterEvents);
  }

  void _filterEvents() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredEvents = events
          .where((event) =>
              event["title"].toLowerCase().contains(query) ||
              event["description"].toLowerCase().contains(query) ||
              event["type"].toLowerCase().contains(query))
          .toList();
    });
  }

  Color _eventColor(String type) {
    switch (type) {
      case "Case":
        return Colors.blue;
      case "Document":
        return Colors.green;
      case "Event":
        return Colors.orange;
      case "User":
        return Colors.purple;
      default:
        return AppColors.iconDefault;
    }
  }

  IconData _eventIcon(String type) {
    switch (type) {
      case "Case":
        return Icons.gavel;
      case "Document":
        return Icons.insert_drive_file;
      case "Event":
        return Icons.event;
      case "User":
        return Icons.person;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Timeline & Events",
            style: theme.textTheme.titleLarge
                ?.copyWith(color: AppColors.buttonTextLight)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔹 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search events...",
                hintStyle: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.cardColor,
              ),
            ),
          ),

          // 🔹 Timeline list
          Expanded(
            child: filteredEvents.isEmpty
                ? Center(
                    child: Text(
                      "No events found",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return _buildTimelineTile(event, theme);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile(Map<String, dynamic> event, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Timeline marker
          Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: _eventColor(event["type"]),
                child: Icon(
                  _eventIcon(event["type"]),
                  color: Colors.white,
                  size: 18,
                ),
              ),
              Container(
                width: 2,
                height: 60,
                color: theme.dividerColor,
              ),
            ],
          ),
          const SizedBox(width: 12),

          // 🔹 Event details
          Expanded(
            child: Card(
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event["title"],
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event["description"],
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event["date"],
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
