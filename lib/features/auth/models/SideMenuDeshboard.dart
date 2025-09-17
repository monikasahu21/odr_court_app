import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/login_screen.dart'; // ✅ import LoginScreen
import 'package:odr_court_app/features/auth/models/MenuItemData.dart';
import 'package:odr_court_app/widgets/app_color.dart';

class SideMenu extends StatelessWidget {
  final int selected;
  final List<MenuItemData> items;
  final Function(int) onItemTap;
  final bool isDrawer; // 👈 pass true if used inside Drawer
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
  Widget build(BuildContext context) {
    return Container(
      width: isDrawer ? null : 220,
      color: AppColors.sidebarBackground,
      child: Column(
        children: [
          // ✅ User info header
          Container(
            color: AppColors.accentOrange,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.cardBackground,
                  child: Icon(Icons.person, color: AppColors.accentOrange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: AppColors.buttonTextLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userRole,
                        style: const TextStyle(
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

          // ✅ Menu items
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final isSelected = i == selected;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Material(
                    color: isSelected
                        ? AppColors.selectedMenu
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        onItemTap(i);
                        // ✅ Close drawer automatically
                        if (isDrawer) Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              items[i].icon,
                              color: isSelected
                                  ? AppColors.buttonTextLight
                                  : AppColors.iconDefault,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                items[i].title,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isSelected
                                      ? AppColors.buttonTextLight
                                      : AppColors.textPrimary,
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

          // ✅ Logout Button at bottom
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.divider)),
              color: AppColors.cardBackground,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // ✅ Close drawer first
                if (isDrawer) Navigator.pop(context);

                // ✅ Navigate back to Login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.logout, color: AppColors.primary),
                  SizedBox(width: 12),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
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
