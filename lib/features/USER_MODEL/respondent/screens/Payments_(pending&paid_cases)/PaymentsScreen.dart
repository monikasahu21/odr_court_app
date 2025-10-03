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
          "Payment of ${payments[index]["amount"]} for ${payments[index]["caseId"]} completed!",
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  /// 🔹 Map status to theme colors
  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return AppColors.accentOrange;
      case "Paid":
        return AppColors.successGreen;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Payments"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        elevation: 2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: payments.length,
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final payment = payments[index];
          return Card(
            color: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.dividerColor),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Case ID
                  Text(
                    "Case: ${payment["caseId"]}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 🔹 Payment Details
                  Text("Amount: ${payment["amount"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Due Date: ${payment["dueDate"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),
                  Text("Method: ${payment["method"]}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textSecondary)),

                  const SizedBox(height: 10),

                  // 🔹 Status + Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: ${payment["status"]}",
                        style: theme.textTheme.bodyMedium?.copyWith(
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
