import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ArbitrationCalculatorScreen extends StatefulWidget {
  const ArbitrationCalculatorScreen({super.key});

  @override
  State<ArbitrationCalculatorScreen> createState() =>
      _ArbitrationCalculatorScreenState();
}

class _ArbitrationCalculatorScreenState
    extends State<ArbitrationCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController claimAmountController = TextEditingController();

  double domesticResult = 0.0;
  double emergencyResult = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Reset input when switching tabs
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          claimAmountController.clear();
        });
      }
    });
  }

  void calculateFees(bool isDomestic) {
    double claimAmount = double.tryParse(claimAmountController.text) ?? 0;

    setState(() {
      if (isDomestic) {
        domesticResult = claimAmount * 0.02; // Example formula
      } else {
        emergencyResult = 50000 + (claimAmount * 0.015); // Example formula
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // 🔹 Custom Top TabBar
          Container(
            color: AppColors.accentOrange,
            child: SafeArea(
              bottom: false,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.buttonTextLight,
                labelColor: AppColors.buttonTextLight,
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: "Domestic"),
                  Tab(text: "Emergency"),
                ],
              ),
            ),
          ),

          // 🔹 Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCalculator(context, true, domesticResult),
                _buildCalculator(context, false, emergencyResult),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculator(
      BuildContext context, bool isDomestic, double result) {
    final theme = Theme.of(context);

    return Padding(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Claim Amount Input
              TextField(
                controller: claimAmountController,
                keyboardType: TextInputType.number,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: "Enter Claim Amount",
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.accentOrange, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.attach_money,
                      color: AppColors.iconDefault),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Calculate Button
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.buttonTextLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  onPressed: () => calculateFees(isDomestic),
                  icon: const Icon(Icons.calculate),
                  label: Text(
                    "Calculate",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.buttonTextLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Result Display
              Center(
                child: Text(
                  "${isDomestic ? "Domestic" : "Emergency"} Fees: ₹${result.toStringAsFixed(2)}",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
