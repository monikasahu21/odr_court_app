import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class ServiceRequestForm extends StatelessWidget {
  const ServiceRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController caseTitleCtrl = TextEditingController();
    final TextEditingController descriptionCtrl = TextEditingController();

    return Scaffold(
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
            Icon(Icons.assignment, color: AppColors.buttonTextLight, size: 24),
            SizedBox(width: 8),
            Text(
              "New Service Request",
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
      backgroundColor: AppColors.background, // ✅ match background
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Case Title
              TextFormField(
                controller: caseTitleCtrl,
                decoration: InputDecoration(
                  labelText: "Case Title",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (v) => v!.isEmpty ? "Enter case title" : null,
              ),
              const SizedBox(height: 12),

              // Case Description
              TextFormField(
                controller: descriptionCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Case Description",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                validator: (v) => v!.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBlue,
                    foregroundColor: AppColors.buttonTextLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("✅ Service Request Submitted"),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
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
