import 'package:flutter/material.dart';
import 'package:odr_court_app/features/USER_MODEL/respondent/screens/Payments_(pending&paid_cases)/resNewPaymentScreen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class RespondentPaymentScreen extends StatelessWidget {
  const RespondentPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> payments = [
      {
        "id": "TXN1001",
        "caseId": "Case #2024-45",
        "amount": "₹2,500",
        "date": "01 Sep 2025",
        "status": "Paid",
      },
      {
        "id": "TXN1002",
        "caseId": "Case #2024-52",
        "amount": "₹1,200",
        "date": "05 Sep 2025",
        "status": "Pending",
      },
      {
        "id": "TXN1003",
        "caseId": "Case #2024-60",
        "amount": "₹3,000",
        "date": "10 Sep 2025",
        "status": "Paid",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewPaymentScreen()),
          );
        },
        icon: const Icon(Icons.add_card),
        label: const Text("New Payment"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          final isPaid = payment["status"] == "Paid";

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isPaid
                    ? [Colors.green.shade400, Colors.green.shade700]
                    : [Colors.red.shade400, Colors.red.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground.withOpacity(0.92),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  // 🔹 Leading Circle Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPaid ? Icons.check_circle : Icons.pending_actions,
                      color: isPaid ? Colors.green : Colors.red,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 🔹 Payment Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          payment["caseId"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Txn: ${payment["id"]} • ${payment["date"]}",
                          style: const TextStyle(
                              fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),

                  // 🔹 Amount + Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        payment["amount"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isPaid ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          payment["status"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
