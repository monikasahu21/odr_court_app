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
    //final loc = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.cardColor, // ✅ adapts to dark/light
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.15),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16, color: theme.iconTheme.color?.withOpacity(0.6)),
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs"),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            iconColor: AppColors.accentOrange,
            collapsedIconColor: theme.iconTheme.color,
            title: Text("How do I reset my password?",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Go to Profile > Change Password and follow the steps.",
                    style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
          ExpansionTile(
            iconColor: AppColors.accentOrange,
            collapsedIconColor: theme.iconTheme.color,
            title: Text("How to change language?",
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Go to Profile > Language and select your language.",
                    style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
