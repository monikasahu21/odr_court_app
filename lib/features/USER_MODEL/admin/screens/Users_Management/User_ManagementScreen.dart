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
      users.removeWhere((u) =>
          u["email"] == filteredUsers[index]["email"]); // remove from main list
      filteredUsers.removeAt(index); // remove from filtered
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
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
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: Icon(Icons.person,
                          color:
                              user["active"] ? AppColors.primary : Colors.grey),
                    ),
                    title: Text(
                      user["name"],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("${user["email"]} • ${user["role"]}"),
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
                          child:
                              Text(user["active"] ? "Deactivate" : "Activate"),
                        ),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text("Delete"),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          _showAddUserDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🔹 Add User Dialog
  void _showAddUserDialog(BuildContext context) {
    String name = "";
    String email = "";
    String role = "Claimant";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add New User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (val) => name = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (val) => email = val,
              ),
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
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text("Add"),
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
            ),
          ],
        );
      },
    );
  }
}
