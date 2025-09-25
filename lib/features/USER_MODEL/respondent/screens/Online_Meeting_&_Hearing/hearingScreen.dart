import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class RespondentHearingScreen extends StatelessWidget {
  const RespondentHearingScreen({super.key});

  Future<void> _joinMeeting(String roomName, String subject) async {
    var jitsiMeet = JitsiMeet();

    var options = JitsiMeetConferenceOptions(
      room: roomName, // unique room ID
      userInfo: JitsiMeetUserInfo(
        displayName: "Respondent User",
        email: "respondent@courtapp.com",
      ),
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": false,
      },
    );

    await jitsiMeet.join(options);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> hearings = [
      {
        "id": "Case #2024-45",
        "title": "Property Dispute",
        "date": "25 Sep 2025",
        "time": "10:30 AM",
        "venue": "Virtual Courtroom",
        "meetingRoom": "court_case_2024_45"
      },
      {
        "id": "Case #2024-52",
        "title": "Cheque Bounce",
        "date": "28 Sep 2025",
        "time": "2:00 PM",
        "venue": "Virtual Courtroom",
        "meetingRoom": "court_case_2024_52"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hearings.length,
        itemBuilder: (context, index) {
          final hearing = hearings[index];
          return Card(
            color: AppColors.cardBackground,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hearing["id"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    hearing["title"]!,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text("${hearing["date"]} • ${hearing["time"]}",
                          style:
                              const TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: AppColors.accentOrange),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(hearing["venue"]!,
                            style: const TextStyle(
                                color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _joinMeeting(
                          hearing["meetingRoom"]!,
                          hearing["title"]!,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.buttonTextLight,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.video_call),
                      label: const Text("Join Hearing"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
