import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  List<Map<String, String>> payments = [
    {
      "caseId": "C-201",
      "amount": "₹2000",
      "dueDate": "30 Sep 2025",
      "status": "Pending",
      "method": "-",
    },
    {
      "caseId": "C-198",
      "amount": "₹1500",
      "dueDate": "20 Sep 2025",
      "status": "Paid",
      "method": "UPI",
    },
    {
      "caseId": "C-190",
      "amount": "₹3000",
      "dueDate": "10 Sep 2025",
      "status": "Paid",
      "method": "Card",
    },
  ];

  void _makePayment(int index) {
    setState(() {
      payments[index]["status"] = "Paid";
      payments[index]["method"] = "UPI";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Payment of ${payments[index]["amount"]} for ${payments[index]["caseId"]} completed!"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return AppColors.accentOrange;
      case "Paid":
        return Colors.green;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: payments.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.divider),
        itemBuilder: (context, index) {
          final payment = payments[index];
          return Card(
            color: AppColors.cardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.divider),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Case: ${payment["caseId"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Amount: ${payment["amount"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Due Date: ${payment["dueDate"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  Text("Method: ${payment["method"]}",
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: ${payment["status"]}",
                        style: TextStyle(
                          color: _statusColor(payment["status"]!),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (payment["status"] == "Pending")
                        ElevatedButton.icon(
                          icon: const Icon(Icons.payment,
                              color: AppColors.buttonTextLight),
                          label: const Text(
                            "Pay Now",
                            style: TextStyle(color: AppColors.buttonTextLight),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _makePayment(index),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
