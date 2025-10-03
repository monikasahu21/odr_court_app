import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String role;
  final String email;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.role,
    required this.email,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _roleController = TextEditingController(text: widget.role);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Edit Profile",
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.buttonTextLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              label: "Full Name",
              theme: theme,
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _roleController,
              label: "Role",
              theme: theme,
              icon: Icons.work,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: "Email",
              theme: theme,
              icon: Icons.email,
            ),
            const SizedBox(height: 24),

            /// 🔹 Save button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.buttonTextLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.save, color: AppColors.buttonTextLight),
                label: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonTextLight,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    "name": _nameController.text,
                    "role": _roleController.text,
                    "email": _emailController.text,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable themed text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required ThemeData theme,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
