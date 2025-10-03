import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ScheduleManageHearingsScreen extends StatefulWidget {
  const ScheduleManageHearingsScreen({super.key});

  @override
  State<ScheduleManageHearingsScreen> createState() =>
      _ScheduleManageHearingsScreenState();
}

class _ScheduleManageHearingsScreenState
    extends State<ScheduleManageHearingsScreen> {
  List<Map<String, String>> hearings = [
    {
      "caseId": "C-301",
      "date": "30 Sep 2025",
      "time": "10:30 AM",
      "judge": "Justice Arvind Kumar",
      "status": "Scheduled",
    },
    {
      "caseId": "C-302",
      "date": "02 Oct 2025",
      "time": "2:00 PM",
      "judge": "Justice Meera Joshi",
      "status": "Scheduled",
    },
    {
      "caseId": "C-295",
      "date": "15 Sep 2025",
      "time": "3:00 PM",
      "judge": "Justice Ramesh Patel",
      "status": "Completed",
    },
  ];

  /// 🔹 Schedule new hearing dialog
  void _scheduleNewHearing() {
    String? caseId, judge;
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Schedule Hearing",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Case ID",
                        labelStyle: theme.textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (val) => caseId = val,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Judge Name",
                        labelStyle: theme.textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (val) => judge = val,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? "Select Date"
                                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today,
                              color: AppColors.primary),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setDialogState(() => selectedDate = picked);
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedTime == null
                                ? "Select Time"
                                : selectedTime!.format(context),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time,
                              color: AppColors.primary),
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setDialogState(() => selectedTime = picked);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.buttonTextLight,
                  ),
                  child: const Text("Save"),
                  onPressed: () {
                    if (caseId != null &&
                        judge != null &&
                        selectedDate != null &&
                        selectedTime != null) {
                      setState(() {
                        hearings.add({
                          "caseId": caseId!,
                          "date":
                              "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                          "time": selectedTime!.format(context),
                          "judge": judge!,
                          "status": "Scheduled",
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// 🔹 Cancel hearing
  void _cancelHearing(int index) {
    setState(() {
      hearings[index]["status"] = "Cancelled";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Hearing for ${hearings[index]["caseId"]} has been cancelled."),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  /// 🔹 Status colors
  Color _statusColor(String status) {
    switch (status) {
      case "Scheduled":
        return AppColors.primary;
      case "Completed":
        return AppColors.successGreen;
      case "Cancelled":
        return AppColors.errorRed;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Manage Hearings",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hearings.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final hearing = hearings[index];
          return Card(
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Case: ${hearing["caseId"]}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("Date: ${hearing["date"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Time: ${hearing["time"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Judge: ${hearing["judge"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text(
                    "Status: ${hearing["status"]}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: _statusColor(hearing["status"]!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (hearing["status"] == "Scheduled")
                        TextButton.icon(
                          icon: const Icon(Icons.cancel,
                              color: AppColors.errorRed),
                          label: Text(
                            "Cancel",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.errorRed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => _cancelHearing(index),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: "Schedule New Hearing",
        onPressed: _scheduleNewHearing,
        child: const Icon(Icons.add, color: AppColors.buttonTextLight),
      ),
    );
  }
}
