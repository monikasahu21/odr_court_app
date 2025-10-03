import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  State<SystemSettingsScreen> createState() => _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends State<SystemSettingsScreen> {
  // Example settings values
  String appName = "ODR Court App";
  String appVersion = "1.0.0";
  bool maintenanceMode = false;

  bool emailNotifications = true;
  bool pushNotifications = true;

  bool twoFactorAuth = false;
  int sessionTimeout = 30; // minutes

  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _appVersionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appNameController.text = appName;
    _appVersionController.text = appVersion;
  }

  void _saveSettings() {
    setState(() {
      appName = _appNameController.text;
      appVersion = _appVersionController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Settings saved successfully")),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: theme.textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    String? subtitle,
  }) {
    final theme = Theme.of(context);

    return SwitchListTile(
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
            )
          : null,
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("System Settings",
            style: theme.textTheme.titleLarge
                ?.copyWith(color: AppColors.buttonTextLight)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Settings
            _buildSectionTitle("⚙️ General Settings", theme),
            Card(
              color: theme.cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _appNameController,
                      decoration: const InputDecoration(
                        labelText: "Application Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _appVersionController,
                      decoration: const InputDecoration(
                        labelText: "App Version",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSwitchTile(
                      title: "Maintenance Mode",
                      subtitle: "Enable to temporarily disable the system",
                      value: maintenanceMode,
                      onChanged: (val) {
                        setState(() => maintenanceMode = val);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Notification Settings
            _buildSectionTitle("🔔 Notification Settings", theme),
            Card(
              color: theme.cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: "Email Notifications",
                    value: emailNotifications,
                    onChanged: (val) {
                      setState(() => emailNotifications = val);
                    },
                  ),
                  Divider(height: 1, color: theme.dividerColor),
                  _buildSwitchTile(
                    title: "Push Notifications",
                    value: pushNotifications,
                    onChanged: (val) {
                      setState(() => pushNotifications = val);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Security Settings
            _buildSectionTitle("🔒 Security Settings", theme),
            Card(
              color: theme.cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: "Enable Two-Factor Authentication (2FA)",
                      value: twoFactorAuth,
                      onChanged: (val) {
                        setState(() => twoFactorAuth = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "Session Timeout (minutes): ",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: Slider(
                            value: sessionTimeout.toDouble(),
                            min: 5,
                            max: 120,
                            divisions: 23,
                            label: "$sessionTimeout",
                            onChanged: (val) {
                              setState(() => sessionTimeout = val.toInt());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Save Button
            Center(
              child: ElevatedButton.icon(
                style: theme.elevatedButtonTheme.style,
                icon: const Icon(Icons.save),
                label: Text(
                  "Save Settings",
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                onPressed: _saveSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
