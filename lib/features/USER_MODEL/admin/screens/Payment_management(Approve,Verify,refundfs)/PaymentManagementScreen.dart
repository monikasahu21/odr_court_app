import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  State<PaymentManagementScreen> createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  List<Map<String, String>> payments = [
    {
      "txnId": "TXN001",
      "user": "Mandeep Kaur",
      "amount": "₹1500",
      "method": "UPI",
      "date": "20 Sep 2025",
      "status": "Pending"
    },
    {
      "txnId": "TXN002",
      "user": "Jagdeesh Rai",
      "amount": "₹2500",
      "method": "Card",
      "date": "21 Sep 2025",
      "status": "Verified"
    },
    {
      "txnId": "TXN003",
      "user": "Mukesh Verma",
      "amount": "₹3000",
      "method": "Bank Transfer",
      "date": "23 Sep 2025",
      "status": "Refunded"
    },
  ];

  String searchQuery = "";

  void _updateStatus(int index, String newStatus) {
    setState(() {
      payments[index]["status"] = newStatus;
    });
  }

  void _showConfirmationDialog(int index, String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "$action Payment",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        content: Text(
          "Are you sure you want to $action this payment (${payments[index]['txnId']})?",
          style: const TextStyle(color: AppColors.textSecondary),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(action,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            onPressed: () {
              Navigator.pop(context);
              _updateStatus(index, action == "Refund" ? "Refunded" : action);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredPayments = payments
        .where((p) =>
            p["txnId"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p["user"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p["status"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Payment Management",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
          ),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Txn ID, User, or Status",
                hintStyle: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: AppColors.cardBackground,
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
          ),

          // 📊 Payments Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStatePropertyAll(
                  AppColors.primary.withOpacity(0.1),
                ),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
                dataRowColor: WidgetStatePropertyAll(AppColors.cardBackground),
                columns: const [
                  DataColumn(label: Text("Txn ID")),
                  DataColumn(label: Text("User")),
                  DataColumn(label: Text("Amount")),
                  DataColumn(label: Text("Method")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: List.generate(filteredPayments.length, (index) {
                  final payment = filteredPayments[index];
                  return DataRow(cells: [
                    DataCell(Text(payment["txnId"]!,
                        style: const TextStyle(color: AppColors.textPrimary))),
                    DataCell(Text(payment["user"]!,
                        style: const TextStyle(color: AppColors.textPrimary))),
                    DataCell(Text(payment["amount"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary))),
                    DataCell(Text(payment["method"]!,
                        style:
                            const TextStyle(color: AppColors.textSecondary))),
                    DataCell(Text(payment["date"]!,
                        style:
                            const TextStyle(color: AppColors.textSecondary))),
                    DataCell(_buildStatusText(payment["status"]!)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.verified, color: Colors.green),
                          tooltip: "Verify",
                          onPressed: payment["status"] == "Pending"
                              ? () => _showConfirmationDialog(index, "Verified")
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.blue),
                          tooltip: "Approve",
                          onPressed: payment["status"] == "Pending"
                              ? () => _showConfirmationDialog(index, "Approved")
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.money_off,
                              color: Colors.redAccent),
                          tooltip: "Refund",
                          onPressed: payment["status"] != "Refunded"
                              ? () => _showConfirmationDialog(index, "Refund")
                              : null,
                        ),
                      ],
                    )),
                  ]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Status Text with Colors
  Widget _buildStatusText(String status) {
    Color color;
    switch (status) {
      case "Pending":
        color = Colors.orange;
        break;
      case "Verified":
        color = Colors.green;
        break;
      case "Approved":
        color = Colors.blue;
        break;
      case "Refunded":
        color = Colors.redAccent;
        break;
      default:
        color = AppColors.textPrimary;
    }

    return Text(
      status,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color),
    );
  }
}
