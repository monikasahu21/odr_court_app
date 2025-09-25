import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/others/HelpSupport/LiveChatScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  /// Function to send email using url_launcher
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@odrcourt.com', // ✅ replace with your official email
      query: Uri.encodeQueryComponent(
        'subject=Support Request&body=Hello Support Team,\n\nI need help regarding...',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("Could not launch email client");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> faqs = [
      {
        "question": "How can I upload my documents?",
        "answer":
            "Go to the Document Workspace screen, click the upload button, and select the file from your device."
      },
      {
        "question": "How do I make a payment?",
        "answer":
            "Navigate to the Payments section, select 'New Payment', and follow the instructions for secure payment."
      },
      {
        "question": "Can I attend hearings online?",
        "answer":
            "Yes, hearings are conducted virtually. You will receive a notification with the joining link before the scheduled time."
      },
      {
        "question": "Who can I contact for technical issues?",
        "answer":
            "You can reach our support team through email or the in-app chat option. We're available 24/7."
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accentOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.headset_mic, size: 40, color: Colors.white),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Need Assistance?\nOur support team is here to help you 24/7.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Contact Us Section
            const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Email Support Button
                _contactOption(
                  icon: Icons.email,
                  color: Colors.blue,
                  label: "Email Support",
                  onTap: _sendEmail, // ✅ calls email support function
                ),
                const SizedBox(width: 16),
                // Chat Support Button
                _contactOption(
                  icon: Icons.chat,
                  color: Colors.green,
                  label: "Live Chat",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LiveChatScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 FAQs
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...faqs.map((faq) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: const Icon(Icons.help_outline,
                        color: AppColors.primary),
                    title: Text(
                      faq["question"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          faq["answer"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // 🔹 Contact Option Widget
  Widget _contactOption({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
