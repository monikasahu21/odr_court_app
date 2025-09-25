import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class PaymentPortalScreen extends StatefulWidget {
  const PaymentPortalScreen({super.key});

  @override
  State<PaymentPortalScreen> createState() => _PaymentPortalScreenState();
}

class _PaymentPortalScreenState extends State<PaymentPortalScreen> {
  final TextEditingController _amountController = TextEditingController();
  String selectedMethod = "UPI";

  void _makePayment() {
    if (_amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter an amount"),
          backgroundColor: AppColors.accentOrange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Payment of ₹${_amountController.text} via $selectedMethod successful!"),
        backgroundColor: AppColors.primary,
      ),
    );

    _amountController.clear();
    setState(() {
      selectedMethod = "UPI";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
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
                // Amount
                const Text(
                  "Enter Amount (INR)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "e.g. 1500",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Payment Method
                const Text(
                  "Select Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedMethod,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: "UPI", child: Text("UPI")),
                    DropdownMenuItem(
                        value: "Card", child: Text("Debit / Credit Card")),
                    DropdownMenuItem(
                        value: "Net Banking", child: Text("Net Banking")),
                    DropdownMenuItem(value: "Wallet", child: Text("Wallet")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedMethod = val!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Payment Summary
                Card(
                  color: AppColors.background,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.divider),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long,
                        color: AppColors.iconDefault),
                    title: const Text(
                      "Payment Summary",
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      "Method: $selectedMethod\nAmount: ₹${_amountController.text.isEmpty ? '0' : _amountController.text}",
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Pay Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.payment,
                        color: AppColors.buttonTextLight),
                    label: const Text(
                      "Make Payment",
                      style: TextStyle(color: AppColors.buttonTextLight),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _makePayment,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
