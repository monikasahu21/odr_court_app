import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class SayaAgentScreen extends StatefulWidget {
  const SayaAgentScreen({super.key});

  @override
  State<SayaAgentScreen> createState() => _SayaAgentScreenState();
}

class _SayaAgentScreenState extends State<SayaAgentScreen> {
  bool agentAssigned = true; // toggle to false to test "no agent" state

  Map<String, String> agentDetails = {
    "name": "Anita Sharma",
    "specialization": "Family Disputes",
    "phone": "+91 98765 43210",
    "email": "anita.sharma@saya.org",
    "status": "Active"
  };

  void _requestAgent() {
    setState(() {
      agentAssigned = true;
      agentDetails = {
        "name": "Ravi Kumar",
        "specialization": "Property Disputes",
        "phone": "+91 91234 56789",
        "email": "ravi.kumar@saya.org",
        "status": "Assigned"
      };
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ New SAYA Agent assigned successfully"),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "SAYA Agent",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: agentAssigned
            ? Card(
                color: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.divider),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(Icons.person,
                            size: 50, color: AppColors.primary),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        agentDetails["name"]!,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        agentDetails["specialization"]!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Contact Info
                      ListTile(
                        leading: const Icon(Icons.phone,
                            color: AppColors.iconDefault),
                        title: Text(agentDetails["phone"]!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.textPrimary,
                            )),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "📞 Calling ${agentDetails["phone"]}...",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.email,
                            color: AppColors.iconDefault),
                        title: Text(agentDetails["email"]!,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.textPrimary,
                            )),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "📧 Sending email to ${agentDetails["email"]}...",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.verified_user,
                            color: AppColors.iconDefault),
                        title: Text(
                          "Status: ${agentDetails["status"]!}",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Chat / Communicate Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.chat,
                              color: AppColors.buttonTextLight),
                          label: const Text(
                            "Start Chat",
                            style: TextStyle(color: AppColors.buttonTextLight),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("💬 Chat feature coming soon..."),
                                backgroundColor: AppColors.accentOrange,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.support_agent,
                        size: 80, color: AppColors.textSecondary),
                    const SizedBox(height: 12),
                    Text(
                      "No SAYA Agent assigned yet.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.person_add,
                          color: AppColors.buttonTextLight),
                      label: const Text(
                        "Request Agent",
                        style: TextStyle(color: AppColors.buttonTextLight),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _requestAgent,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
