import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/role.dart';

class RegisterScreen extends StatefulWidget {
  final Role role; // default role (from Login)
  final void Function({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobile,
    required String country,
    required Role role,
    Map<String, String>? extraFields,
  }) onRegister;

  const RegisterScreen({
    super.key,
    required this.role,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  // Role-specific
  final _adminCodeController = TextEditingController();
  final _caseIdController = TextEditingController();
  final _licenseController = TextEditingController();

  // States
  Role _selectedRole = Role.claimant;
  String _country = 'India';
  bool _obscurePassword = true;
  bool _agreeTerms = false;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.role;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Title ----------
              Text(
                'Create ${_selectedRole.name[0].toUpperCase()}${_selectedRole.name.substring(1)} Account',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // ---------- Select Role ----------
              DropdownButtonFormField<Role>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: "Select Role *",
                  labelStyle: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: Role.values
                    .map((r) => DropdownMenuItem(
                          value: r,
                          child: Text(r.name,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textPrimary)),
                        ))
                    .toList(),
                onChanged: (r) {
                  if (r != null) setState(() => _selectedRole = r);
                },
              ),
              const SizedBox(height: 20),

              // ---------- Full Name ----------
              _field(controller: _fullNameController, label: 'Full Name *'),
              const SizedBox(height: 20),

              // ---------- Email ----------
              _field(
                controller: _emailController,
                label: 'Email',
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // ---------- Password ----------
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  labelStyle: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.iconDefault,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ---------- Country ----------
              SizedBox(
                height: 55,
                child: _dropdown(
                  label: "Country *",
                  value: _country,
                  items: const ['India', 'USA', 'UK'],
                  onChanged: (v) => setState(() => _country = v ?? 'India'),
                ),
              ),
              const SizedBox(height: 20),

              // ---------- Mobile ----------
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.divider),
                      borderRadius: BorderRadius.circular(8),
                      color: theme.cardColor,
                    ),
                    child: Text(
                      '+91',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _field(
                      controller: _mobileController,
                      label: 'Mobile Number',
                      keyboard: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---------- Role-Specific Extra Fields ----------
              ..._roleSpecificFields(),

              const SizedBox(height: 5),

              // ---------- Terms ----------
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: _agreeTerms,
                    onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                  ),
                  Expanded(
                    child: Text(
                      "I agree to the Terms and Conditions",
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ---------- Register Button ----------
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.buttonTextLight,
                    disabledBackgroundColor: theme.disabledColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _agreeTerms
                      ? () {
                          final fullName = _fullNameController.text.trim();
                          final parts = fullName.split(" ");
                          final firstName = parts.isNotEmpty ? parts.first : "";
                          final lastName = parts.length > 1
                              ? parts.sublist(1).join(" ")
                              : "";

                          widget.onRegister(
                            firstName: firstName,
                            lastName: lastName,
                            email: _emailController.text,
                            password: _passwordController.text,
                            mobile: _mobileController.text,
                            country: _country,
                            role: _selectedRole,
                            extraFields: _collectExtraFields(),
                          );
                        }
                      : null,
                  child: Text(
                    'Register',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      color: AppColors.buttonTextLight,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ---------- Already Registered ----------
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Already have an account? Login",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
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

  /// Reusable text field
  Widget _field({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
  }) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      keyboardType: keyboard,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium
            ?.copyWith(color: AppColors.textSecondary),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Dropdown
  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium
            ?.copyWith(color: AppColors.textSecondary),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textPrimary)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  /// Role-specific extra fields
  List<Widget> _roleSpecificFields() {
    switch (_selectedRole) {
      case Role.admin:
        return [
          _field(controller: _adminCodeController, label: 'Admin Code *')
        ];
      case Role.claimant:
        return [_field(controller: _caseIdController, label: 'Case ID *')];
      case Role.respondent:
        return [
          _field(controller: _caseIdController, label: 'Respondent Case ID *')
        ];
      case Role.neutral:
        return [
          _field(
            controller: _licenseController,
            label: 'License/Registration No. *',
          )
        ];
    }
  }

  /// Collect extra fields
  Map<String, String> _collectExtraFields() {
    switch (_selectedRole) {
      case Role.admin:
        return {'adminCode': _adminCodeController.text};
      case Role.claimant:
        return {'caseId': _caseIdController.text};
      case Role.respondent:
        return {'caseId': _caseIdController.text};
      case Role.neutral:
        return {'license': _licenseController.text};
    }
  }
}
