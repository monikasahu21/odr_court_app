import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/models/MenuItemData.dart';

class RoleMenus {
  // Admin menu
  static const admin = [
    MenuItemData('Home', Icons.home),
    MenuItemData('Users', Icons.people),
    MenuItemData('Reports', Icons.bar_chart),
    MenuItemData('Settings', Icons.settings),
  ];

  // Claimant menu (matches your 2nd screenshot)
  static const claimant = [
    MenuItemData('Dashboard', Icons.dashboard),
    MenuItemData('Case Register', Icons.article),
    MenuItemData('Outcome', Icons.assignment_turned_in),
    MenuItemData('Communication', Icons.chat),
    MenuItemData('File Service Request', Icons.folder_open),
    MenuItemData('Upload Documents', Icons.upload_file),
    MenuItemData('Make Payment', Icons.payment),
    MenuItemData('Saya Agent', Icons.support_agent),
    MenuItemData('Help', Icons.help_outline),
  ];

  // Respondent menu (slightly different focus)
  static const respondent = [
    MenuItemData('Dashboard', Icons.dashboard),
    MenuItemData('Assigned Cases', Icons.assignment),
    MenuItemData('Outcome', Icons.assignment_turned_in),
    MenuItemData('Communication', Icons.chat),
    MenuItemData('Help', Icons.help_outline),
  ];

  // Neutral (mediator / arbitrator)
  static const neutral = [
    MenuItemData('Dashboard', Icons.dashboard),
    MenuItemData('Case Reviews', Icons.rate_review),
    MenuItemData('Schedule', Icons.calendar_today),
    MenuItemData('Communication', Icons.chat),
    MenuItemData('Help', Icons.help_outline),
  ];
}
