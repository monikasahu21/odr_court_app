import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ServiceRequestsScreen extends StatefulWidget {
  const ServiceRequestsScreen({super.key});

  @override
  State<ServiceRequestsScreen> createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends State<ServiceRequestsScreen> {
  List<Map<String, String>> requests = [
    {
      "reqId": "REQ101",
      "user": "Amit Sharma",
      "subject": "Login issue",
      "date": "20 Sep 2025",
      "status": "Pending",
      "response": ""
    },
    {
      "reqId": "REQ102",
      "user": "Priya Singh",
      "subject": "Payment not reflected",
      "date": "21 Sep 2025",
      "status": "In Progress",
      "response": "We are checking with the finance team."
    },
    {
      "reqId": "REQ103",
      "user": "Rahul Verma",
      "subject": "Unable to upload documents",
      "date": "22 Sep 2025",
      "status": "Resolved",
      "response": "Issue has been fixed. Please retry."
    },
  ];

  String searchQuery = "";

  void _updateStatus(int index, String newStatus) {
    setState(() {
      requests[index]["status"] = newStatus;
    });
  }

  void _respondToRequest(int index) {
    String reply = requests[index]["response"] ?? "";
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Respond to ${requests[index]['reqId']}",
            style: theme.textTheme.titleLarge,
          ),
          content: TextField(
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Your Response",
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: reply),
            onChanged: (val) => reply = val,
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Send"),
              onPressed: () {
                setState(() {
                  requests[index]["response"] = reply;
                  requests[index]["status"] = "In Progress";
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Resolved":
        return Colors.green;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredRequests = requests
        .where((r) =>
            r["reqId"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["user"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["subject"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            r["status"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Service Requests",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Request ID, User, Subject, or Status",
                hintStyle: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.iconDefault),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.cardColor,
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
          ),

          // 📋 Requests Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    WidgetStatePropertyAll(AppColors.primary.withOpacity(0.08)),
                columns: [
                  _buildColumn("Request ID", theme),
                  _buildColumn("User", theme),
                  _buildColumn("Subject", theme),
                  _buildColumn("Date", theme),
                  _buildColumn("Status", theme),
                  _buildColumn("Response", theme),
                  _buildColumn("Actions", theme),
                ],
                rows: List.generate(filteredRequests.length, (index) {
                  final req = filteredRequests[index];
                  return DataRow(cells: [
                    DataCell(Text(req["reqId"]!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textPrimary))),
                    DataCell(Text(req["user"]!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary))),
                    DataCell(Text(req["subject"]!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary))),
                    DataCell(Text(req["date"]!,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondary))),
                    DataCell(Text(
                      req["status"]!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _statusColor(req["status"]!),
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                    DataCell(Text(
                      req["response"]!.isEmpty
                          ? "No response yet"
                          : req["response"]!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppColors.textSecondary),
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.reply, color: Colors.blue),
                          tooltip: "Respond",
                          onPressed: () => _respondToRequest(index),
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            _updateStatus(index, value);
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                                value: "Pending", child: Text("Mark Pending")),
                            PopupMenuItem(
                                value: "In Progress",
                                child: Text("Mark In Progress")),
                            PopupMenuItem(
                                value: "Resolved",
                                child: Text("Mark Resolved")),
                          ],
                          child: const Icon(Icons.more_vert,
                              color: AppColors.iconDefault),
                        ),
                      ],
                    )),
                  ]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _buildColumn(String title, ThemeData theme) {
    return DataColumn(
      label: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
