import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ScheduleHearingsScreen extends StatefulWidget {
  const ScheduleHearingsScreen({super.key});

  @override
  State<ScheduleHearingsScreen> createState() => _ScheduleHearingsScreenState();
}

class _ScheduleHearingsScreenState extends State<ScheduleHearingsScreen> {
  List<Map<String, String>> hearings = [
    {
      "caseId": "C-101",
      "parties": "Rajesh Soni",
      "date": "28 Sep 2025",
      "time": "11:00 AM",
      "judge": "Justice Rao",
      "status": "Scheduled"
    },
    {
      "caseId": "C-102",
      "parties": "Vibha Shah",
      "date": "01 Oct 2025",
      "time": "2:30 PM",
      "judge": "Justice Mehta",
      "status": "Scheduled"
    },
  ];

  void _addHearing() {
    String? caseId, parties, judge, remarks;
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Schedule Hearing",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField("Case ID", (val) => caseId = val),
                    _buildTextField("Parties Involved", (val) => parties = val),
                    _buildTextField("Judge", (val) => judge = val),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedDate == null
                                ? "Select Date"
                                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
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
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
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
                    _buildTextField("Remarks", (val) => remarks = val),
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
                  child: const Text("Save"),
                  onPressed: () {
                    if (caseId != null &&
                        parties != null &&
                        selectedDate != null &&
                        selectedTime != null) {
                      setState(() {
                        hearings.add({
                          "caseId": caseId!,
                          "parties": parties!,
                          "date":
                              "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                          "time": selectedTime!.format(context),
                          "judge": judge ?? "Not Assigned",
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

  void _deleteHearing(int index) {
    setState(() {
      hearings.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Schedule Hearings",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              WidgetStateProperty.all(AppColors.primary.withOpacity(0.1)),
          columns: [
            _buildColumn("Case ID", theme),
            _buildColumn("Parties", theme),
            _buildColumn("Date", theme),
            _buildColumn("Time", theme),
            _buildColumn("Judge", theme),
            _buildColumn("Status", theme),
            _buildColumn("Actions", theme),
          ],
          rows: List.generate(hearings.length, (index) {
            final hearing = hearings[index];
            return DataRow(cells: [
              DataCell(Text(hearing["caseId"]!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textPrimary))),
              DataCell(Text(hearing["parties"]!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary))),
              DataCell(Text(hearing["date"]!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary))),
              DataCell(Text(hearing["time"]!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary))),
              DataCell(Text(hearing["judge"]!,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary))),
              DataCell(Text(
                hearing["status"]!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: "Edit Hearing",
                    onPressed: () {
                      // TODO: Implement edit
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: "Delete Hearing",
                    onPressed: () => _deleteHearing(index),
                  ),
                ],
              )),
            ]);
          }),
        ),
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

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
