import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Case_Information&Case_Management/CaseInforScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Submitted_Documents%20_(Approve&Reject)/SubmittedDocumentScreen.dart';
import 'package:odr_court_app/features/USER_MODEL/admin/screens/Users_Management/UsersScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class AdminControlScreen extends StatelessWidget {
  const AdminControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> controls = [
      {
        "title": "Manage Users_Management",
        "icon": Icons.people,
        "color": Colors.blue,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UsersScreen()),
          );
        },
      },
      {
        "title": "Manage Cases",
        "icon": Icons.folder_copy,
        "color": Colors.orange,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CaseInformationScreen()),
          );
        },
      },
      {
        "title": "Submitted Documents",
        "icon": Icons.insert_drive_file,
        "color": Colors.green,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SubmittedDocumentsScreen()),
          );
        },
      },
      {
        "title": "Reports&Analytics",
        "icon": Icons.bar_chart,
        "color": Colors.purple,
        "onTap": () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ReportsScreen()),
          // );
        },
      },
      {
        "title": "Settings",
        "icon": Icons.settings,
        "color": Colors.redAccent,
        "onTap": () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SettingsScreen()),
          // );
        },
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: GridView.builder(
          itemCount: controls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final control = controls[index];
            return GestureDetector(
              onTap: () => control["onTap"](), // 👈 call navigation
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: control["color"].withOpacity(0.15),
                      child: Icon(control["icon"],
                          size: 32, color: control["color"]),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      control["title"],
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
