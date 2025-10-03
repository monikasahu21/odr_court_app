import 'dart:io';

import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/MenuItemData.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/models/login/login_screen.dart';
import 'package:odr_court_app/features/auth/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  final int selected;
  final List<MenuItemData> items;
  final Function(int) onItemTap;
  final bool isDrawer;
  final String userRole;
  final String userName;

  const SideMenu({
    super.key,
    required this.selected,
    required this.items,
    required this.onItemTap,
    required this.userRole,
    required this.userName,
    this.isDrawer = false,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString("profileImagePath");
    if (savedPath != null && mounted) {
      setState(() {
        _profileImage = File(savedPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);

    return Container(
      width: widget.isDrawer ? null : 220,
      color: theme.cardColor, // adapts to theme
      child: Column(
        children: [
          // 🔹 User info header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accentOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  backgroundImage: userProvider.avatarPath != null
                      ? FileImage(File(userProvider.avatarPath!))
                      : null,
                  child: userProvider.avatarPath == null
                      ? const Icon(Icons.person,
                          color: AppColors.buttonTextLight)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.buttonTextLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userProvider.role,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Menu items
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, i) {
                final isSelected = i == widget.selected;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Material(
                    color: isSelected
                        ? AppColors.selectedMenu
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        widget.onItemTap(i);
                        if (widget.isDrawer) Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              widget.items[i].icon,
                              color: isSelected
                                  ? AppColors.buttonTextLight
                                  : (theme.brightness == Brightness.dark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.iconDefault),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                widget.items[i].title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15,
                                  color: isSelected
                                      ? AppColors.buttonTextLight
                                      : (theme.brightness == Brightness.dark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.textPrimary),
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔹 Logout Button
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: theme.dividerColor)),
              color: theme.cardColor,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                if (widget.isDrawer) Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.logout,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.darkTextPrimary
                          : AppColors.primary),
                  const SizedBox(width: 12),
                  Text(
                    "Logout",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.darkTextPrimary
                          : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
