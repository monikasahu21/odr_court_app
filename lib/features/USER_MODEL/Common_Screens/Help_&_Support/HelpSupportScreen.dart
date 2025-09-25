import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart'; // ✅ for localization
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  // 🔹 Launch email
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@odrcourtapp.com',
      query: 'subject=ODR Court App Support&body=Hello, I need help with...',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // 🔹 Launch phone dialer
  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+91 9876543210');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // 🔹 Launch website
  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse("https://www.odrcourtapp.com/help");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context); // ✅ localization

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            context,
            icon: Icons.email,
            title: "Email Us",
            subtitle: "support@odrcourtapp.com",
            onTap: _launchEmail,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            icon: Icons.phone,
            title: "Call Us",
            subtitle: "+91 9876543210",
            onTap: _launchPhone,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            icon: Icons.language,
            title: "Visit Website",
            subtitle: "www.odrcourtapp.com/help",
            onTap: _launchWebsite,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            icon: Icons.question_answer,
            title: "FAQs",
            subtitle: "Find answers to common questions",
            onTap: () {
              // Navigate to FAQs page (optional)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FaqScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppColors.textSecondary)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

// 🔹 Optional FAQ screen
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text("How do I reset my password?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Go to Profile > Change Password and follow the steps."),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("How to change language?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Go to Profile > Language and select your language."),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
