import 'package:flutter/material.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:odr_court_app/widgets/app_color.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = "UPI (Google Pay / PhonePe)";
  String? _upiResponse;
  List<ApplicationMeta>? _upiApps;

  final List<Map<String, dynamic>> _methods = [
    {
      "name": "UPI (Google Pay / PhonePe)",
      "icon": Icons.account_balance_wallet
    },
    {"name": "Credit / Debit Card", "icon": Icons.credit_card},
    {"name": "Net Banking", "icon": Icons.account_balance},
    {"name": "Wallet (Paytm / Others)", "icon": Icons.wallet},
    {"name": "Cash on Delivery", "icon": Icons.money},
  ];

  @override
  void initState() {
    super.initState();
    _loadUpiApps();
  }

  Future<void> _loadUpiApps() async {
    final apps = await UpiPay.getInstalledUpiApplications(
      statusType: UpiApplicationDiscoveryAppStatusType.all,
    );
    setState(() {
      _upiApps = apps;
    });
  }

  Future<void> _makeUpiPayment(ApplicationMeta app) async {
    try {
      final response = await UpiPay.initiateTransaction(
        amount: "10.00",
        app: app.upiApplication,
        receiverName: "ODR Court",
        receiverUpiAddress: "example@upi", // ⚠️ replace with valid UPI ID
        transactionRef: "TID${DateTime.now().millisecondsSinceEpoch}",
        transactionNote: "Case Payment",
      );

      setState(() {
        _upiResponse = response.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Response: $response")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("UPI Payment Failed ❌ $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.accentOrange,
        elevation: 4, // ✅ adds soft shadow
        centerTitle: true, // ✅ center align title
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8), // ✅ rounded bottom corners
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // ✅ keeps icon+text centered
          children: const [
            Icon(Icons.payments_outlined,
                color: AppColors.buttonTextLight, size: 24),
            SizedBox(width: 8),
            Text(
              "Payment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.buttonTextLight,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.buttonTextLight),
        toolbarHeight: 40, // ✅ taller for better look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Payment Methods
            Expanded(
              child: ListView.builder(
                itemCount: _methods.length,
                itemBuilder: (context, i) {
                  final method = _methods[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: RadioListTile<String>(
                      value: method["name"],
                      groupValue: _selectedMethod,
                      activeColor: AppColors.accentOrange,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                      title: Text(method["name"]),
                      secondary: Icon(method["icon"]),
                    ),
                  );
                },
              ),
            ),

            // UPI Apps if UPI is selected
            if (_selectedMethod.contains("UPI") && _upiApps != null) ...[
              const SizedBox(height: 20),
              const Text("Select UPI App:",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                children: _upiApps!
                    .map((app) => InkWell(
                          onTap: () => _makeUpiPayment(app),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              app.iconImage(48),
                              const SizedBox(height: 4),
                              Text(app.upiApplication.getAppName(),
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],

            if (_upiResponse != null) ...[
              const SizedBox(height: 20),
              Text("Response: $_upiResponse"),
            ],
          ],
        ),
      ),
    );
  }
}
