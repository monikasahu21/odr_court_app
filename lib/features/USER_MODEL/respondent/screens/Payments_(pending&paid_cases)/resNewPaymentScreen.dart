import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class NewPaymentScreen extends StatefulWidget {
  const NewPaymentScreen({super.key});

  @override
  State<NewPaymentScreen> createState() => _NewPaymentScreenState();
}

class _NewPaymentScreenState extends State<NewPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCase;
  String? _amount;
  String _paymentMethod = "UPI";

  final List<String> _caseIds = [
    "Case #2024-45",
    "Case #2024-52",
    "Case #2024-60",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.accentOrange,
        title: const Text("New Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Case ID Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCase,
                decoration: InputDecoration(
                  labelText: "Select Case",
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _caseIds
                    .map((caseId) =>
                        DropdownMenuItem(value: caseId, child: Text(caseId)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCase = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select a case" : null,
              ),
              const SizedBox(height: 20),

              // Amount Field
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount (₹)",
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => _amount = value,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter amount" : null,
              ),
              const SizedBox(height: 20),

              // Payment Method
              const Text("Select Payment Method",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 10),
              RadioListTile(
                title: const Text("UPI"),
                value: "UPI",
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Credit/Debit Card"),
                value: "Card",
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Net Banking"),
                value: "NetBanking",
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Processing payment of ₹$_amount for $_selectedCase via $_paymentMethod",
                        ),
                      ),
                    );
                    Navigator.pop(context); // back after payment
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonTextLight,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.payment),
                label: const Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
