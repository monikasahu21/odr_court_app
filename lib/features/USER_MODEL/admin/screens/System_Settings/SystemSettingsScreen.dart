import 'package:flutter/material.dart';

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
      const SnackBar(content: Text("Settings saved successfully")),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    String? subtitle,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Settings
            _buildSectionTitle("General Settings"),
            TextField(
              controller: _appNameController,
              decoration: const InputDecoration(
                labelText: "Application Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _appVersionController,
              decoration: const InputDecoration(
                labelText: "App Version",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            _buildSwitchTile(
              title: "Maintenance Mode",
              subtitle: "Enable to temporarily disable the system",
              value: maintenanceMode,
              onChanged: (val) {
                setState(() => maintenanceMode = val);
              },
            ),

            const Divider(height: 30),

            // Notification Settings
            _buildSectionTitle("Notification Settings"),
            _buildSwitchTile(
              title: "Email Notifications",
              value: emailNotifications,
              onChanged: (val) {
                setState(() => emailNotifications = val);
              },
            ),
            _buildSwitchTile(
              title: "Push Notifications",
              value: pushNotifications,
              onChanged: (val) {
                setState(() => pushNotifications = val);
              },
            ),

            const Divider(height: 30),

            // Security Settings
            _buildSectionTitle("Security Settings"),
            _buildSwitchTile(
              title: "Enable Two-Factor Authentication (2FA)",
              value: twoFactorAuth,
              onChanged: (val) {
                setState(() => twoFactorAuth = val);
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Session Timeout (minutes): "),
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

            const SizedBox(height: 20),

            // Save Button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Settings"),
                onPressed: _saveSettings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
