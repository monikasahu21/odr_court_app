import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // Example Indian user data
  final List<Map<String, String>> users = [
    {
      "name": "Amit Sharma",
      "email": "amit.sharma@example.com",
      "role": "Claimant"
    },
    {
      "name": "Priya Verma",
      "email": "priya.verma@example.com",
      "role": "Respondent"
    },
    {
      "name": "Rahul Mehta",
      "email": "rahul.mehta@example.com",
      "role": "Neutral"
    },
    {
      "name": "Sneha Kapoor",
      "email": "sneha.kapoor@example.com",
      "role": "Admin"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Text(
                    user["name"]![0], // first letter of name
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  user["name"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user["email"]!,
                        style: const TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        user["role"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          size: 20, color: AppColors.primary),
                      onPressed: () {
                        // 👉 Handle edit
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        // 👉 Handle delete
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add, color: AppColors.buttonTextLight),
        label: const Text(
          "Add User",
          style: TextStyle(color: AppColors.buttonTextLight),
        ),
        onPressed: () {
          // 👉 Add new user logic here
        },
      ),
    );
  }
}
