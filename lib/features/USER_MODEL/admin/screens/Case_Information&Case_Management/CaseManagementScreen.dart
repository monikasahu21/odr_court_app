import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CaseManagementScreen extends StatefulWidget {
  const CaseManagementScreen({super.key});

  @override
  State<CaseManagementScreen> createState() => _CaseManagementScreenState();
}

class _CaseManagementScreenState extends State<CaseManagementScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> cases = [
    {
      "caseId": "C-1001",
      "parties": "Ravi Kumar vs. Neha Gupta",
      "neutral": "Justice Arjun",
      "status": "Open",
      "date": "25-Sep-2025"
    },
    {
      "caseId": "C-1002",
      "parties": "Anjali vs. XYZ Corp",
      "neutral": "Dr. Meera",
      "status": "In Progress",
      "date": "20-Sep-2025"
    },
    {
      "caseId": "C-1003",
      "parties": "Sohan vs. Mohan",
      "neutral": "Justice Rao",
      "status": "Resolved",
      "date": "15-Sep-2025"
    },
  ];

  List<Map<String, dynamic>> filteredCases = [];

  @override
  void initState() {
    super.initState();
    filteredCases = cases;
    _searchController.addListener(_filterCases);
  }

  void _filterCases() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCases = cases
          .where((c) =>
              c["caseId"].toLowerCase().contains(query) ||
              c["parties"].toLowerCase().contains(query) ||
              c["neutral"].toLowerCase().contains(query) ||
              c["status"].toLowerCase().contains(query))
          .toList();
    });
  }

  void _updateCaseStatus(int index, String newStatus) {
    setState(() {
      filteredCases[index]["status"] = newStatus;
      cases.firstWhere(
        (c) => c["caseId"] == filteredCases[index]["caseId"],
      )["status"] = newStatus;
    });
  }

  void _deleteCase(int index) {
    setState(() {
      cases.removeWhere((c) => c["caseId"] == filteredCases[index]["caseId"]);
      filteredCases.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Case Management",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          // 🔹 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                hintText: "Search cases...",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
              ),
            ),
          ),

          // 🔹 Cases List
          Expanded(
            child: ListView.builder(
              itemCount: filteredCases.length,
              itemBuilder: (context, index) {
                final caseItem = filteredCases[index];
                return Card(
                  color: AppColors.cardBackground,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: const Icon(Icons.gavel, color: AppColors.primary),
                    ),
                    title: Text(
                      caseItem["caseId"],
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Parties: ${caseItem["parties"]}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                          Text("Neutral: ${caseItem["neutral"]}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                          Text("Date: ${caseItem["date"]}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          _buildStatusChip(caseItem["status"]),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "delete") {
                          _deleteCase(index);
                        } else {
                          _updateCaseStatus(index, value);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                            value: "Open", child: Text("Mark as Open")),
                        const PopupMenuItem(
                            value: "In Progress",
                            child: Text("Mark as In Progress")),
                        const PopupMenuItem(
                            value: "Resolved", child: Text("Mark as Resolved")),
                        const PopupMenuItem(
                            value: "Closed", child: Text("Mark as Closed")),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: "delete",
                          child: Text(
                            "Delete Case",
                            style: TextStyle(color: Colors.red),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => _showAddCaseDialog(context),
        child: const Icon(Icons.add, color: AppColors.buttonTextLight),
      ),
    );
  }

  // 🔹 Add Case Dialog
  void _showAddCaseDialog(BuildContext context) {
    String caseId = "";
    String parties = "";
    String neutral = "";
    String status = "Open";
    String date = DateTime.now().toString().substring(0, 10);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Add New Case",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Case ID"),
                  onChanged: (val) => caseId = val,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(labelText: "Parties"),
                  onChanged: (val) => parties = val,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Assigned Neutral"),
                  onChanged: (val) => neutral = val,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: "Open", child: Text("Open")),
                    DropdownMenuItem(
                        value: "In Progress", child: Text("In Progress")),
                    DropdownMenuItem(
                        value: "Resolved", child: Text("Resolved")),
                    DropdownMenuItem(value: "Closed", child: Text("Closed")),
                  ],
                  onChanged: (val) => status = val!,
                  decoration: const InputDecoration(labelText: "Status"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: AppColors.textSecondary)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.buttonTextLight,
              ),
              child: const Text("Add",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onPressed: () {
                if (caseId.isNotEmpty &&
                    parties.isNotEmpty &&
                    neutral.isNotEmpty) {
                  setState(() {
                    cases.add({
                      "caseId": caseId,
                      "parties": parties,
                      "neutral": neutral,
                      "status": status,
                      "date": date,
                    });
                    filteredCases = cases;
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

  /// 🔹 Status Chip
  Widget _buildStatusChip(String status) {
    Color color = _statusColor(status);
    return Chip(
      label: Text(
        status,
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.orange;
      case "In Progress":
        return Colors.blue;
      case "Resolved":
        return Colors.green;
      case "Closed":
        return Colors.redAccent;
      default:
        return AppColors.textPrimary;
    }
  }
}
