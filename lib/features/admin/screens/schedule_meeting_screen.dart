import 'package:flutter/material.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  DateTime? _date;
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(_date == null ? 'Select date' : _date!.toLocal().toString().split(' ')[0]),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (d != null) setState(() => _date = d);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(_time == null ? 'Select time' : _time!.format(context)),
              onTap: () async {
                final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                if (t != null) setState(() => _time = t);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (_date != null && _time != null)
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meeting scheduled (demo)')));
                    }
                  : null,
              child: const Text('Schedule'),
            ),
            const SizedBox(height: 12),
            const Text('Note: For real video conferencing integration, add a service like Jitsi / WebRTC and a backend to store meeting links.'),
          ],
        ),
      ),
    );
  }
}
