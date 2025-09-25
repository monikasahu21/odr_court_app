import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CaseInformationScreen extends StatefulWidget {
  const CaseInformationScreen({super.key});

  @override
  State<CaseInformationScreen> createState() => _CaseInformationScreenState();
}

class _CaseInformationScreenState extends State<CaseInformationScreen> {
  // Example case data (replace with DB/API later)
  final List<Map<String, String>> cases = [
    {
      "caseId": "C-2025-001",
      "title": "Land Dispute between Sharma & Singh",
      "claimant": "Amit Sharma",
      "respondent": "Vikram Singh",
      "status": "Active",
      "date": "18 Sept 2025"
    },
    {
      "caseId": "C-2025-002",
      "title": "Contract Breach: Verma vs Mehta",
      "claimant": "Priya Verma",
      "respondent": "Rahul Mehta",
      "status": "Pending",
      "date": "20 Sept 2025"
    },
    {
      "caseId": "C-2025-003",
      "title": "Payment Dispute: Kapoor vs Joshi",
      "claimant": "Sneha Kapoor",
      "respondent": "Neha Joshi",
      "status": "Closed",
      "date": "10 Sept 2025"
    },
  ];

  // controllers
  final TextEditingController _caseIdCtrl = TextEditingController();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _claimantCtrl = TextEditingController();
  final TextEditingController _respondentCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController();
  String _selectedStatus = "Active";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView.builder(
          itemCount: cases.length,
          itemBuilder: (context, index) {
            final caseData = cases[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
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
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Case ID + Date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          caseData["caseId"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          caseData["date"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Title
                    Text(
                      caseData["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Claimant vs Respondent
                    Row(
                      children: [
                        const Icon(Icons.account_circle,
                            color: AppColors.primary, size: 18),
                        const SizedBox(width: 6),
                        Text("Claimant: ${caseData["claimant"]}",
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            color: AppColors.accentOrange, size: 18),
                        const SizedBox(width: 6),
                        Text("Respondent: ${caseData["respondent"]}",
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Status + Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(caseData["status"]!,
                              style: TextStyle(
                                  color: _getStatusColor(caseData["status"]!),
                                  fontWeight: FontWeight.w500)),
                          backgroundColor: _getStatusColor(caseData["status"]!)
                              .withOpacity(0.15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              onPressed: () {
                                _showCaseDetailsDialog(context, caseData);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.accentOrange,
                                size: 20,
                              ),
                              onPressed: () {
                                _showEditCaseDialog(context, index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  size: 20, color: Colors.black),
                              onPressed: () {
                                _confirmDeleteCase(context, index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120,
        height: 50,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add, color: AppColors.buttonTextLight),
          label: const Text(
            "Add Case",
            style: TextStyle(color: AppColors.buttonTextLight, fontSize: 14),
          ),
          onPressed: () {
            _showAddCaseDialog(context);
          },
        ),
      ),
    );
  }

  // ✅ Status color
  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Closed":
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  // ✅ Build form fields (used for Add & Edit)
  Widget _buildCaseFormFields() {
    return Column(
      children: [
        TextField(
          controller: _caseIdCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.confirmation_number),
            labelText: "Case ID",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _titleCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.title),
            labelText: "Case Title",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _claimantCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.account_circle),
            labelText: "Claimant",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _respondentCtrl,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            labelText: "Respondent",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _dateCtrl,
          readOnly: true, // 👈 prevents manual typing
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today),
            labelText: "Date",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000), // 👈 minimum date
              lastDate: DateTime(2100), // 👈 maximum date
            );

            if (pickedDate != null) {
              setState(() {
                _dateCtrl.text =
                    "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedStatus,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.flag),
            labelText: "Status",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          items: ["Active", "Pending", "Closed"]
              .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedStatus = value!;
            });
          },
        ),
      ],
    );
  }

  // ✅ Add Case
  void _showAddCaseDialog(BuildContext context) {
    _caseIdCtrl.clear();
    _titleCtrl.clear();
    _claimantCtrl.clear();
    _respondentCtrl.clear();
    _dateCtrl.clear();
    _selectedStatus = "Active";

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Add New Case",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary)),
                  const SizedBox(height: 20),
                  _buildCaseFormFields(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(100, 40)),
                        icon: const Icon(Icons.save,
                            color: AppColors.buttonTextLight),
                        label: const Text("Save",
                            style: TextStyle(color: AppColors.buttonTextLight)),
                        onPressed: () {
                          setState(() {
                            cases.add({
                              "caseId": _caseIdCtrl.text,
                              "title": _titleCtrl.text,
                              "claimant": _claimantCtrl.text,
                              "respondent": _respondentCtrl.text,
                              "status": _selectedStatus,
                              "date": _dateCtrl.text,
                            });
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ View Case
  void _showCaseDetailsDialog(
      BuildContext context, Map<String, String> caseData) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caseData["title"]!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary)),
                const SizedBox(height: 12),
                Text("Case ID: ${caseData["caseId"]}"),
                Text("Claimant: ${caseData["claimant"]}"),
                Text("Respondent: ${caseData["respondent"]}"),
                Text("Status: ${caseData["status"]}"),
                Text("Date: ${caseData["date"]}"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text("Close"),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // ✅ Edit Case
  void _showEditCaseDialog(BuildContext context, int index) {
    final caseData = cases[index];
    _caseIdCtrl.text = caseData["caseId"]!;
    _titleCtrl.text = caseData["title"]!;
    _claimantCtrl.text = caseData["claimant"]!;
    _respondentCtrl.text = caseData["respondent"]!;
    _dateCtrl.text = caseData["date"]!;
    _selectedStatus = caseData["status"]!;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Edit Case",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentOrange)),
                  const SizedBox(height: 20),
                  _buildCaseFormFields(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentOrange,
                            minimumSize: const Size(100, 40)),
                        icon: const Icon(Icons.save,
                            color: AppColors.buttonTextLight),
                        label: const Text("Update",
                            style: TextStyle(color: AppColors.buttonTextLight)),
                        onPressed: () {
                          setState(() {
                            cases[index] = {
                              "caseId": _caseIdCtrl.text,
                              "title": _titleCtrl.text,
                              "claimant": _claimantCtrl.text,
                              "respondent": _respondentCtrl.text,
                              "status": _selectedStatus,
                              "date": _dateCtrl.text,
                            };
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ Delete Case
  void _confirmDeleteCase(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Delete Case"),
          content: const Text("Are you sure you want to delete this case?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text("Delete", style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  cases.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
