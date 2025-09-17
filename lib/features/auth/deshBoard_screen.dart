import 'package:flutter/material.dart';
import 'package:odr_court_app/features/admin/widget/ExperienceForm.dart';
import 'package:odr_court_app/features/auth/models/MenuItemData.dart';
import 'package:odr_court_app/features/auth/models/SideMenuDeshboard.dart';
import 'package:odr_court_app/features/auth/models/role_menus.dart';
import 'package:odr_court_app/features/claimant/deshboard_contant/communication_screen.dart';
import 'package:odr_court_app/features/claimant/deshboard_contant/document_upload_screen.dart';
import 'package:odr_court_app/features/claimant/deshboard_contant/payment_screen.dart';
import 'package:odr_court_app/features/claimant/deshboard_contant/service_request_form.dart';
import 'package:odr_court_app/widgets/app_color.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  final String role;
  final List<MenuItemData> menuItems;

  const DashboardScreen({
    super.key,
    required this.userName,
    required this.role,
    required this.menuItems,
  });

  /// ✅ Factory to create correct dashboard for role
  factory DashboardScreen.forRole({
    required String userName,
    required String role,
  }) {
    switch (role.toLowerCase()) {
      case 'admin':
        return DashboardScreen(
          userName: userName,
          role: role,
          menuItems: RoleMenus.admin,
        );
      case 'claimant':
        return DashboardScreen(
          userName: userName,
          role: role,
          menuItems: RoleMenus.claimant,
        );
      case 'respondent':
        return DashboardScreen(
          userName: userName,
          role: role,
          menuItems: RoleMenus.respondent,
        );
      case 'neutral':
        return DashboardScreen(
          userName: userName,
          role: role,
          menuItems: RoleMenus.neutral,
        );
      default:
        return DashboardScreen(
          userName: userName,
          role: role,
          menuItems: const [MenuItemData('Home', Icons.home)],
        );
    }
  }

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final wide = c.maxWidth >= 700;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: wide
              ? null
              : AppBar(
                  backgroundColor: AppColors.accentOrange,
                  title: Text(
                    widget.menuItems[_selected].title,
                    style: const TextStyle(color: AppColors.buttonTextLight),
                  ),
                ),
          drawer: wide
              ? null
              : Drawer(
                  child: SideMenu(
                    selected: _selected,
                    items: widget.menuItems,
                    onItemTap: (i) => setState(() => _selected = i),
                    userRole: widget.role,
                    userName: widget.userName,
                    isDrawer: true,
                  ),
                ),
          body: Row(
            children: [
              if (wide)
                SideMenu(
                  selected: _selected,
                  items: widget.menuItems,
                  onItemTap: (i) => setState(() => _selected = i),
                  userRole: widget.role,
                  userName: widget.userName,
                ),
              Expanded(child: _content()),
            ],
          ),
        );
      },
    );
  }

  /// right content
  Widget _content() {
    final title = widget.menuItems[_selected].title;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.iconDefault,
          child: Icon(Icons.person, size: 50, color: AppColors.buttonTextLight),
        ),
        const SizedBox(height: 8),
        Text(widget.userName,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Text("Role: ${widget.role}",
            style:
                const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSection(title),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// ✅ Decide which screen to show
  Widget _buildSection(String title) {
    switch (title) {
      case 'Experience':
        return const ExperienceForm();
      case 'Communication':
        return const CommunicationScreen();
      case 'File Service Request':
        return const ServiceRequestForm();
      case 'Upload Documents':
        return const DocumentUploadScreen();
      case 'Make Payment':
        return const PaymentScreen();
      default:
        return _defaultSection(title);
    }
  }

  Widget _defaultSection(String t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t == 'Home' ? 'About' : t,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
          ),
          Divider(color: AppColors.divider),
          const SizedBox(height: 8),
          const Text(
            '-',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      );
}
