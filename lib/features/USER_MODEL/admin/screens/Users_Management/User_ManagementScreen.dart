import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class UsersManagementScreen extends StatefulWidget {
  const UsersManagementScreen({super.key});

  @override
  State<UsersManagementScreen> createState() => _UsersManagementScreenState();
}

class _UsersManagementScreenState extends State<UsersManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 🔹 Dummy users (replace with API/Firebase later)
  List<Map<String, dynamic>> users = [
    {
      "name": "Monika Sahu",
      "email": "monika@example.com",
      "role": "Admin",
      "active": true
    },
    {
      "name": "Ravi Kumar",
      "email": "ravi@example.com",
      "role": "Claimant",
      "active": true
    },
    {
      "name": "Anjali Verma",
      "email": "anjali@example.com",
      "role": "Respondent",
      "active": false
    },
    {
      "name": "Neha Gupta",
      "email": "neha@example.com",
      "role": "Neutral",
      "active": true
    },
  ];

  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users
          .where((user) =>
              user["name"].toLowerCase().contains(query) ||
              user["email"].toLowerCase().contains(query) ||
              user["role"].toLowerCase().contains(query))
          .toList();
    });
  }

  void _toggleActive(int index) {
    setState(() {
      filteredUsers[index]["active"] = !filteredUsers[index]["active"];
    });
  }

  void _deleteUser(int index) {
    setState(() {
      users.removeWhere(
          (u) => u["email"] == filteredUsers[index]["email"]); // remove main
      filteredUsers.removeAt(index); // remove filtered
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // 🔹 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search users...",
                hintStyle: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.cardColor,
              ),
            ),
          ),

          // 🔹 Users list
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: theme.cardColor,
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.primaryColor.withOpacity(0.15),
                      child: Icon(
                        Icons.person,
                        color: user["active"]
                            ? theme.primaryColor
                            : AppColors.textSecondary,
                      ),
                    ),
                    title: Text(
                      user["name"],
                      style: theme.textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      "${user["email"]} • ${user["role"]}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "toggle") {
                          _toggleActive(index);
                        } else if (value == "delete") {
                          _deleteUser(index);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "toggle",
                          child: Text(
                            user["active"] ? "Deactivate" : "Activate",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text(
                            "Delete",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // 🔹 FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          _showAddUserDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // 🔹 Add User Dialog
  void _showAddUserDialog(BuildContext context) {
    final theme = Theme.of(context);
    String name = "";
    String email = "";
    String role = "Claimant";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Add New User", style: theme.textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (val) => name = val,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (val) => email = val,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                  DropdownMenuItem(value: "Claimant", child: Text("Claimant")),
                  DropdownMenuItem(
                      value: "Respondent", child: Text("Respondent")),
                  DropdownMenuItem(value: "Neutral", child: Text("Neutral")),
                ],
                onChanged: (val) => role = val!,
                decoration: const InputDecoration(labelText: "Role"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty && email.isNotEmpty) {
                  setState(() {
                    users.add({
                      "name": name,
                      "email": email,
                      "role": role,
                      "active": true
                    });
                    filteredUsers = users;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
