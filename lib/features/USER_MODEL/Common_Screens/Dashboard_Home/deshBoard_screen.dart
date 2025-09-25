import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Dashboard_Home/CommonDashboardScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Dashboard_Home/SideMenuDeshboard.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Help_&_Support/HelpSupportScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Notifications_(updates,alerts,case_assignments)/Notifications.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Profile&Settings/ProfileSettingsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Neutral/Screens/Assigned_Cases_Overview/AssignedCasesOverviewScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Neutral/Screens/Schedule_&_Manage_Hearings/ScheduleManageHearingsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Neutral/Screens/Scrutinize_Submissions/ScrutinizeSubmissionsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/Neutral/Screens/Upload_Orders&_Awards&_Notes/UploadOrdersAwardsNotesScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Admin_Control/AdminControlsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Case_Information&Case_Management/CaseManagementScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Payment_management(Approve,Verify,refundfs)/PaymentManagementScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Reports&Analytics/ReportsAnalyticsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Schedule_Hearings/ScheduleHearingsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Service_Requests_(track&respond)/ServiceRequestsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Submitted_Documents%20_(Approve&Reject)/SubmittedDocumentsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/System_Settings/SystemSettingsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Timeline&Events/TimelineEventsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Users_Management/User_ManagementScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/Case_Status_Tracking/CaseStatusTrackingScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/Communication/CommunicationScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/FileNewCase_&_ServiceRequest/FileNewCaseScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/Online_Hearing_Access/OnlineHearingAccessScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/Payment_Portal/PaymentPortalScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/SayaAgent/SayaAgentScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/claimant/Screens/Upload_&_SubmitDocuments/UploadDocumentsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Case_Details_&_Submissions/CaseDetailsScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Documents_Workspace/DocumentsWorkspaceScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Events_&_Schedule/EventsScheduleScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Online_Meeting_&_Hearing/OnlineMeetingScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Payments_(pending&paid_cases)/PaymentsScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/MenuItemData.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/role_menus.dart';

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

  /// ✅ Factory: Common + Role-Specific Menus
  factory DashboardScreen.forRole({
    required String userName,
    required String role,
  }) {
    final combinedMenu = [
      ...RoleMenus.common, // always include common menus
      ..._roleSpecificMenus(role), // role-specific
    ];

    return DashboardScreen(
      userName: userName,
      role: role,
      menuItems: combinedMenu,
    );
  }

  /// ✅ Helper for role-specific menus
  static List<MenuItemData> _roleSpecificMenus(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return RoleMenus.admin;
      case 'claimant':
        return RoleMenus.claimant;
      case 'respondent':
        return RoleMenus.respondent;
      case 'neutral':
        return RoleMenus.neutral;
      default:
        return [];
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

  /// Right content
  Widget _content() {
    final title = widget.menuItems[_selected].title;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                padding: const EdgeInsets.all(10),
                child: _buildSection(title),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// ✅ Route mapping
  /// ✅ Route mapping
  Widget _buildSection(String title) {
    final role = widget.role.toLowerCase();

    // 🔹 Common screens
    switch (title) {
      case 'Dashboard / Home':
        return CommonDashboardScreen(
          role: widget.role,
          userName: widget.userName,
        );

      case 'Notifications (updates, alerts, case assignments)':
        return const NotificationsScreen();

      case 'Profile & Settings':
        return ProfileSettingsScreen(
          userName: widget.userName,
          role: widget.role,
          email: "user@email.com", // TODO: replace with actual logged-in email
        );

      case 'Help & Support':
        return const HelpSupportScreen();
    }

    // 🔹 Admin
    if (role == "admin") {
      switch (title) {
        case 'Users Management':
          return const UsersManagementScreen();
        case 'Case Information / Case Management':
          return const CaseManagementScreen();
        case 'Submitted Documents (Approve/Reject)':
          return const SubmittedDocumentsScreen();
        case 'Admin Controls':
          return const AdminControlsScreen();
        case 'Timeline / Events':
          return const TimelineEventsScreen();
        case 'Reports & Analytics':
          return const ReportsAnalyticsScreen();
        case 'Schedule Hearings':
          return const ScheduleHearingsScreen();
        case 'Payment Management (approve, verify, refunds)':
          return const PaymentManagementScreen();
        case 'Service Requests (track/respond)':
          return const ServiceRequestsScreen();
        case 'System Settings':
          return const SystemSettingsScreen();
      }
    }

    // 🔹 Respondent
    if (role == "respondent") {
      switch (title) {
        case 'Case Details / Submissions':
          return const CaseDetailsScreen();
        case 'Online Meeting / Hearing':
          return const OnlineMeetingScreen();
        case 'Documents Workspace':
          return const DocumentsWorkspaceScreen();
        case 'Events & Schedule':
          return const EventsScheduleScreen();
        case 'Payments (pending/paid cases)':
          return const PaymentsScreen();
      }
    }

    // 🔹 Claimant
    if (role == "claimant") {
      switch (title) {
        case 'Communication':
          return const CommunicationScreen();
        case 'File New Case / Service Request':
          return const FileNewCaseScreen();
        case 'Upload / Submit Documents':
          return const UploadDocumentsScreen();
        case 'Payment Portal':
          return const PaymentPortalScreen();
        case 'Saya Agent':
          return const SayaAgentScreen();
        case 'Case Status Tracking':
          return const CaseStatusTrackingScreen();
        case 'Online Hearing Access':
          return const OnlineHearingAccessScreen();
      }
    }

    // 🔹 Neutral
    if (role == "neutral") {
      switch (title) {
        case 'Assigned Cases Overview':
          return const AssignedCasesOverviewScreen();
        case 'Scrutinize Submissions (Claimant / Respondent)':
          return const ScrutinizeSubmissionsScreen();
        case 'Schedule & Manage Hearings':
          return const ScheduleManageHearingsScreen();
        case 'Upload Orders / Awards / Notes':
          return const UploadOrdersAwardsNotesScreen();
      }
    }

    return _defaultSection(title); // ✅ always returns Widget
  }

  Widget _defaultSection(String t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
          ),
          Divider(color: AppColors.divider),
          const SizedBox(height: 8),
          const Text('-',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        ],
      );
}
