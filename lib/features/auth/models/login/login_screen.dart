import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odr_court_app/features/USER_MODEL/Common_Screens/Dashboard_Home/deshBoard_screen.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/MenuItemData.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/role.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/role_menus.dart';
import 'package:odr_court_app/features/auth/models/ragister/ragister_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Role? _selectedRole; // ✅ store selected user role

  final List<Role> _roles = const [
    Role.admin,
    Role.claimant,
    Role.respondent,
    Role.neutral,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: size.width < 500 ? size.width : 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ---------- Logo ----------
                CircleAvatar(
                  radius: 40,
                  backgroundColor: theme.cardColor,
                  child: Icon(Icons.gavel,
                      size: 50, color: AppColors.accentOrange),
                ),
                const SizedBox(height: 12),
                Text("UC ADR",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    )),
                Text("Resolve disputes online",
                    style: GoogleFonts.poppins(color: AppColors.textSecondary)),

                const SizedBox(height: 40),

                // ---------- Card ----------
                Card(
                  color: theme.cardColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Sign In",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            )),
                        const SizedBox(height: 20),

                        // Email
                        TextField(
                          controller: _emailController,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: theme.textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                            prefixIcon: Icon(Icons.email_outlined,
                                color: AppColors.iconDefault),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: theme.textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textSecondary),
                            prefixIcon: Icon(Icons.lock_outline,
                                color: AppColors.iconDefault),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.iconDefault,
                              ),
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ---------- Role Dropdown ----------
                        DropdownButtonFormField<Role>(
                          value: _selectedRole,
                          hint: const Text("Select Role"),
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          items: _roles
                              .map((r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r.name,
                                        style: theme.textTheme.bodyMedium),
                                  ))
                              .toList(),
                          onChanged: (role) =>
                              setState(() => _selectedRole = role),
                        ),

                        const SizedBox(height: 20),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.buttonTextLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_selectedRole == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please select a role")),
                                );
                                return;
                              }

                              final email = _emailController.text.trim();

                              // ✅ Use entered email as username (or fetch from DB if needed)
                              final userName = email.isNotEmpty
                                  ? email.split('@')[0]
                                  : "User";

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DashboardScreen.forRole(
                                    userName: userName,
                                    role: _selectedRole!.name,
                                  ),
                                ),
                              );
                            },
                            child: Text("Login",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonTextLight,
                                )),
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(
                                  role: _selectedRole ?? Role.claimant,
                                  onRegister: ({
                                    required String firstName,
                                    required String lastName,
                                    required String email,
                                    required String password,
                                    required String mobile,
                                    required String country,
                                    required Role role,
                                    Map<String, String>? extraFields,
                                  }) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Registered as ${role.name} ($email) ${extraFields != null ? " Extra: $extraFields" : ""}",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Create an account",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Helper: return menu items based on role
  List<MenuItemData> _getMenuItemsForRole(Role role) {
    switch (role) {
      case Role.admin:
        return RoleMenus.admin;
      case Role.claimant:
        return RoleMenus.claimant;
      case Role.respondent:
        return RoleMenus.respondent;
      case Role.neutral:
        return RoleMenus.neutral;
    }
  }
}
