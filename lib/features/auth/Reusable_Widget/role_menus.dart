import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/MenuItemData.dart';

class RoleMenus {
  // 🔹 Common menu (visible for all users)
  static final common = [
    MenuItemData('Dashboard / Home', Icons.dashboard),
    MenuItemData('Notifications (updates, alerts, case assignments)',
        Icons.notifications),
    MenuItemData('Profile & Settings', Icons.person),
    MenuItemData('Help & Support', Icons.help_outline),

    // ✅ Added calculators with screens
    MenuItemData(
      'Arbitration Calculators',
      Icons.calculate,
    ),
  ];

  // 🔹 Admin menu
  static const admin = [
    MenuItemData('Users Management', Icons.people), // 👥 Manage users
    MenuItemData('Case Information / Case Management', Icons.folder_open), // 📂
    MenuItemData(
        'Submitted Documents (Approve/Reject)', Icons.description), // 📄
    MenuItemData('Admin Controls', Icons.admin_panel_settings), // 🛠️
    MenuItemData('Timeline / Events', Icons.timeline), // ⏳
    MenuItemData('Schedule Hearings', Icons.event), // 📅
    MenuItemData('Reports & Analytics', Icons.bar_chart), // 📊
    MenuItemData(
        'Payment Management (approve, verify, refunds)', Icons.payment), // 💳
    MenuItemData('Service Requests (track/respond)', Icons.request_page), // 📝
    MenuItemData('System Settings', Icons.settings), // ⚙️
  ];

  // 🔹 Claimant menu
  static const claimant = [
    MenuItemData('Communication', Icons.chat), // 💬
    MenuItemData('File New Case / Service Request', Icons.note_add), // 📝
    MenuItemData('Upload / Submit Documents', Icons.upload_file), // 📤
    MenuItemData('Payment Portal', Icons.account_balance_wallet), // 💰
    MenuItemData('Saya Agent', Icons.support_agent), // 👩‍💼
    MenuItemData('Case Status Tracking', Icons.track_changes), // 📊
    MenuItemData('Online Hearing Access', Icons.video_call), // 🎥
  ];

  // 🔹 Respondent menu
  static const respondent = [
    MenuItemData('Case Details / Submissions', Icons.assignment),
    MenuItemData('Online Meeting / Hearing', Icons.video_call),
    MenuItemData('Documents Workspace', Icons.folder_shared),
    MenuItemData('Events & Schedule', Icons.event_note),
    MenuItemData('Payments (pending/paid cases)', Icons.payment),
  ];

  // 🔹 Neutral (Arbitrator / Mediator) menu
  static const neutral = [
    MenuItemData('Assigned Cases Overview', Icons.rate_review),
    MenuItemData(
        'Scrutinize Submissions (Claimant / Respondent)', Icons.fact_check),
    MenuItemData('Schedule & Manage Hearings', Icons.calendar_today),
    MenuItemData('Upload Orders / Awards / Notes', Icons.upload_file),
  ];
}
