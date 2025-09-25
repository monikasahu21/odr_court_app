import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NeutralScheduleHearingsScreen extends StatefulWidget {
  const NeutralScheduleHearingsScreen({super.key});

  @override
  State<NeutralScheduleHearingsScreen> createState() =>
      _NeutralScheduleHearingsScreenState();
}

class _NeutralScheduleHearingsScreenState
    extends State<NeutralScheduleHearingsScreen> {
  // 🔹 Dummy hearings data
  final List<Map<String, String>> hearings = [
    {
      "caseId": "CASE-2025-001",
      "title": "Rahul Sharma vs Meera Singh",
      "date": "25 Sep 2025",
      "time": "10:30 AM",
      "venue": "Virtual Courtroom",
    },
    {
      "caseId": "CASE-2025-002",
      "title": "Anil Kumar vs State Bank",
      "date": "28 Sep 2025",
      "time": "02:00 PM",
      "venue": "District Court - Room 3",
    },
  ];

  // 🔹 Add New Hearing Dialog
  void _scheduleHearing() {
    final _caseIdController = TextEditingController();
    final _titleController = TextEditingController();
    final _venueController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Schedule New Hearing"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _caseIdController,
                decoration: const InputDecoration(labelText: "Case ID"),
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Case Title"),
              ),
              TextField(
                controller: _venueController,
                decoration: const InputDecoration(labelText: "Venue"),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(selectedDate == null
                          ? "Pick Date"
                          : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => selectedDate = picked);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.access_time),
                      label: Text(selectedTime == null
                          ? "Pick Time"
                          : "${selectedTime!.hour}:${selectedTime!.minute}"),
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() => selectedTime = picked);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_caseIdController.text.isNotEmpty &&
                  _titleController.text.isNotEmpty &&
                  selectedDate != null &&
                  selectedTime != null) {
                setState(() {
                  hearings.add({
                    "caseId": _caseIdController.text,
                    "title": _titleController.text,
                    "date":
                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                    "time": "${selectedTime!.hour}:${selectedTime!.minute}",
                    "venue": _venueController.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentOrange,
        onPressed: _scheduleHearing,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hearings.length,
          itemBuilder: (context, index) {
            final hearing = hearings[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: const Icon(Icons.gavel,
                    color: AppColors.accentOrange, size: 30),
                title: Text(
                  hearing["title"]!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  "${hearing["caseId"]}\n${hearing["date"]} • ${hearing["time"]}\n${hearing["venue"]}",
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Edit") {
                      // TODO: implement edit logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Editing ${hearing["caseId"]}"),
                        ),
                      );
                    } else if (value == "Cancel") {
                      setState(() => hearings.removeAt(index));
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: "Edit", child: Text("Edit Hearing")),
                    const PopupMenuItem(
                        value: "Cancel", child: Text("Cancel Hearing")),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
