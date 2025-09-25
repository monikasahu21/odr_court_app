import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Profile&Settings/ChangePasswardScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final String userName;
  final String role;
  final String email;

  const ProfileSettingsScreen({
    super.key,
    required this.userName,
    required this.role,
    required this.email,
  });

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  // 🔹 State variables for toggles
  bool _isNotificationEnabled = true;
  bool _isDarkModeEnabled = false;
  bool _isDataSaverEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          /// 🔹 Collapsible Profile Header
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accentOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: _buildProfileHeader(),
              ),
            ),
          ),

          /// 🔹 Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🟦 Account Section
                  _buildSectionTitle("Account"),
                  const SizedBox(height: 10),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.lock,
                      title: "Change Password",
                      color: AppColors.primary,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen()),
                        );
                      },
                    ),
                    _divider(),
                    _buildSettingsTile(
                      icon: Icons.language,
                      title: "Language",
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                    _divider(),
                    _buildSettingsTile(
                      icon: Icons.privacy_tip,
                      title: "Privacy Settings",
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                    _divider(),
                    _buildSettingsTile(
                      icon: Icons.subscriptions,
                      title: "Manage Subscriptions",
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 25),

                  /// 🟧 Preferences Section
                  _buildSectionTitle("Preferences"),
                  const SizedBox(height: 10),
                  _buildSettingsCard([
                    _buildSwitchTile(
                      icon: Icons.notifications,
                      title: "Enable Notifications",
                      value: _isNotificationEnabled, // ✅ FIXED
                      onChanged: (v) {
                        setState(() {
                          _isNotificationEnabled = v;
                        });
                      },
                    ),
                    _divider(),
                    _buildSwitchTile(
                      icon: Icons.dark_mode,
                      title: "Dark Mode",
                      value: _isDarkModeEnabled, // ✅ FIXED
                      onChanged: (v) {
                        setState(() {
                          _isDarkModeEnabled = v;
                        });
                        // TODO: Add logic to apply theme
                      },
                    ),
                    _divider(),
                    _buildSwitchTile(
                      icon: Icons.data_saver_on,
                      title: "Data Saver",
                      value: _isDataSaverEnabled, // ✅ FIXED
                      onChanged: (v) {
                        setState(() {
                          _isDataSaverEnabled = v;
                        });
                      },
                    ),
                  ]),
                  const SizedBox(height: 25),

                  /// 🟥 Other Section
                  _buildSectionTitle("Other"),
                  const SizedBox(height: 10),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                    _divider(),
                    _buildSettingsTile(
                      icon: Icons.info,
                      title: "About App",
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                    _divider(),
                    _buildSettingsTile(
                      icon: Icons.logout,
                      title: "Logout",
                      color: Colors.redAccent,
                      onTap: () {},
                      isLogout: true,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Profile Header Content
  Widget _buildProfileHeader() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 60, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              Text(
                widget.userName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                widget.role,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                widget.email,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // TODO: Navigate to edit profile
                },
                icon: const Icon(Icons.edit, size: 16),
                label: const Text("Edit Profile"),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary),
    );
  }

  /// 🔹 Settings Card Wrapper
  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(children: children),
    );
  }

  /// 🔹 Divider
  Widget _divider() => const Divider(height: 1, color: AppColors.divider);

  /// 🔹 Reusable Tile
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.redAccent : AppColors.textPrimary,
        ),
      ),
      trailing: isLogout
          ? null
          : const Icon(Icons.arrow_forward_ios,
              size: 16, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  /// 🔹 Switch Tile
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      ),
      value: value,
      activeColor: AppColors.accentOrange,
      onChanged: onChanged,
    );
  }
}
