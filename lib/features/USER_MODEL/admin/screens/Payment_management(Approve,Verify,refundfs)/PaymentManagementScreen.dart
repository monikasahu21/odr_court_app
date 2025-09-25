import 'package:flutter/material.dart';

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
        title: Text("$action Payment"),
        content: Text(
            "Are you sure you want to $action this payment (${payments[index]['txnId']})?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(action),
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
    final filteredPayments = payments
        .where((p) =>
            p["txnId"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p["user"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p["status"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Management"),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by Txn ID, User, or Status",
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
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
                    DataCell(Text(payment["txnId"]!)),
                    DataCell(Text(payment["user"]!)),
                    DataCell(Text(payment["amount"]!)),
                    DataCell(Text(payment["method"]!)),
                    DataCell(Text(payment["date"]!)),
                    DataCell(Text(payment["status"]!)),
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
}
