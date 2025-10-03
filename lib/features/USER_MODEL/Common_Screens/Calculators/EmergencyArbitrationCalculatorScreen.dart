import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class EmergencyArbitrationCalculatorScreen extends StatefulWidget {
  const EmergencyArbitrationCalculatorScreen({super.key});

  @override
  _EmergencyArbitrationCalculatorScreenState createState() =>
      _EmergencyArbitrationCalculatorScreenState();
}

class _EmergencyArbitrationCalculatorScreenState
    extends State<EmergencyArbitrationCalculatorScreen> {
  final TextEditingController claimAmountController = TextEditingController();
  double result = 0.0;

  void calculateFees() {
    double claimAmount = double.tryParse(claimAmountController.text) ?? 0;
    setState(() {
      // Example formula: Flat ₹50,000 + 1.5% of claim
      result = 50000 + (claimAmount * 0.015);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextLight,
        title: Text(
          "Emergency Arbitration Calculator",
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: theme.cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.divider),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Claim Amount Input
                TextField(
                  controller: claimAmountController,
                  keyboardType: TextInputType.number,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter Claim Amount",
                    labelStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.accentOrange, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.attach_money,
                        color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 20),

                // Calculate Button
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.buttonTextLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: calculateFees,
                    icon: const Icon(Icons.calculate,
                        color: AppColors.buttonTextLight),
                    label: Text(
                      "Calculate",
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.buttonTextLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Result Display
                Center(
                  child: Text(
                    "Emergency Arbitration Fees:\n₹${result.toStringAsFixed(2)}",
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
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
