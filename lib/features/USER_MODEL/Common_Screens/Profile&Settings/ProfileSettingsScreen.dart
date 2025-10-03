import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Profile&Settings/ChangePasswardScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Profile&Settings/EditProfileScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_state.dart';
import 'package:odr_court_app/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isNotificationEnabled = true;
  bool _isDataSaverEnabled = false;
  String _selectedLanguage = "English";
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadPreferences();
    _loadLanguage();
  }

  /// 🔹 Profile Image
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString("profileImagePath");
    if (savedPath != null && mounted) {
      setState(() => _profileImage = File(savedPath));
      Provider.of<UserProvider>(context, listen: false).updateAvatar(savedPath);
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        final path = picked.path;
        setState(() => _profileImage = File(path));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("profileImagePath", path);

        Provider.of<UserProvider>(context, listen: false).updateAvatar(path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick image")),
      );
    }
  }

  /// 🔹 Preferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationEnabled = prefs.getBool("notifications") ?? true;
      _isDataSaverEnabled = prefs.getBool("dataSaver") ?? false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  /// 🔹 Language
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString("appLanguageCode") ?? "en";

    setState(() {
      _selectedLanguage = code == "hi" ? "हिन्दी" : "English";
    });

    Provider.of<AppState>(context, listen: false).setLocale(Locale(code));
  }

  Future<void> _changeLanguage(Locale locale, String languageName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("appLanguageCode", locale.languageCode);

    Provider.of<AppState>(context, listen: false).setLocale(locale);

    setState(() {
      _selectedLanguage = languageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);
    final loc = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
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
                child: _buildProfileHeader(userProvider, theme),
              ),
            ),
          ),

          /// Body Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(loc!.account, theme),
                  const SizedBox(height: 10),
                  _buildSettingsCard(theme, [
                    _buildSettingsTile(
                      icon: Icons.lock,
                      title: loc.changePassword,
                      color: AppColors.primary,
                      theme: theme,
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
                      title: "${loc.language} ($_selectedLanguage)",
                      color: AppColors.primary,
                      theme: theme,
                      onTap: _showLanguageDialog,
                    ),
                  ]),
                  const SizedBox(height: 25),
                  _buildSectionTitle(loc.preferences, theme),
                  const SizedBox(height: 10),
                  _buildSettingsCard(theme, [
                    _buildSwitchTile(
                      icon: Icons.notifications,
                      title: loc.enableNotifications,
                      value: _isNotificationEnabled,
                      theme: theme,
                      onChanged: (v) {
                        setState(() => _isNotificationEnabled = v);
                        _savePreference("notifications", v);
                      },
                    ),
                    _divider(),
                    Consumer<AppState>(
                      builder: (context, appState, _) {
                        return _buildSwitchTile(
                          icon: Icons.dark_mode,
                          title: loc.darkMode,
                          value: appState.isDarkMode,
                          theme: theme,
                          onChanged: (v) => appState.toggleDarkMode(v),
                        );
                      },
                    ),
                    _divider(),
                    _buildSwitchTile(
                      icon: Icons.data_saver_on,
                      title: loc.dataSaver,
                      value: _isDataSaverEnabled,
                      theme: theme,
                      onChanged: (v) {
                        setState(() => _isDataSaverEnabled = v);
                        _savePreference("dataSaver", v);
                      },
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

  /// 🔹 Profile Header
  Widget _buildProfileHeader(UserProvider userProvider, ThemeData theme) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  backgroundImage: userProvider.avatarPath != null
                      ? FileImage(File(userProvider.avatarPath!))
                      : null,
                  child: userProvider.avatarPath == null
                      ? const Icon(Icons.person,
                          size: 60, color: AppColors.primary)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentOrange,
                      ),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              userProvider.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.buttonTextLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(userProvider.role,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                )),
            const SizedBox(height: 4),
            Text(userProvider.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                )),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      name: userProvider.name,
                      role: userProvider.role,
                      email: userProvider.email,
                    ),
                  ),
                );

                if (updated != null && mounted) {
                  userProvider.updateProfile(
                    name: updated['name'],
                    role: updated['role'],
                    email: updated['email'],
                  );
                }
              },
              icon: const Icon(Icons.edit, size: 16),
              label: Text(S.of(context)!.editProfile),
            )
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(S.of(context)!.language,
              style: Theme.of(context).textTheme.titleMedium),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption("English", const Locale('en')),
              _languageOption("हिन्दी", const Locale('hi')),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(String language, Locale locale) {
    return RadioListTile<String>(
      value: language,
      groupValue: _selectedLanguage,
      title: Text(language,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
              )),
      activeColor: AppColors.primary,
      onChanged: (value) {
        if (value != null) {
          _changeLanguage(locale, value);
        }
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) => Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      );

  Widget _buildSettingsCard(ThemeData theme, List<Widget> children) => Card(
        color: theme.cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(children: children),
      );

  Widget _divider() => const Divider(height: 1, color: AppColors.divider);

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Color color,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color),
      ),
      title: Text(title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          )),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: theme.iconTheme.color),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ThemeData theme,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary.withOpacity(0.15),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          )),
      value: value,
      activeColor: AppColors.accentOrange,
      onChanged: onChanged,
    );
  }
}
