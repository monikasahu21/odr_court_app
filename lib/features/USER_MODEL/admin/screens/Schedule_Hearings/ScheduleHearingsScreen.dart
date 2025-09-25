import 'package:flutter/material.dart';

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
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Schedule Hearing"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Case ID"),
                      onChanged: (val) => caseId = val,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: "Parties Involved"),
                      onChanged: (val) => parties = val,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: "Judge"),
                      onChanged: (val) => judge = val,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(selectedDate == null
                              ? "Select Date"
                              : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
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
                          child: Text(selectedTime == null
                              ? "Select Time"
                              : selectedTime!.format(context)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time),
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
                    TextField(
                      decoration: const InputDecoration(labelText: "Remarks"),
                      onChanged: (val) => remarks = val,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Hearings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addHearing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          columns: const [
            DataColumn(label: Text("Case ID")),
            DataColumn(label: Text("Parties")),
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Time")),
            DataColumn(label: Text("Judge")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: List.generate(hearings.length, (index) {
            final hearing = hearings[index];
            return DataRow(cells: [
              DataCell(Text(hearing["caseId"]!)),
              DataCell(Text(hearing["parties"]!)),
              DataCell(Text(hearing["date"]!)),
              DataCell(Text(hearing["time"]!)),
              DataCell(Text(hearing["judge"]!)),
              DataCell(Text(hearing["status"]!)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Edit functionality can be added here
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
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
}
