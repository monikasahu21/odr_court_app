import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odr_court_app/features/auth/deshBoard_screen.dart'; // ✅ DashboardScreen
import 'package:odr_court_app/features/auth/models/MenuItemData.dart';
import 'package:odr_court_app/features/auth/models/role.dart';
import 'package:odr_court_app/features/auth/models/role_menus.dart';
import 'package:odr_court_app/features/auth/ragister_screen.dart';
import 'package:odr_court_app/widgets/app_color.dart';

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

    return Scaffold(
      backgroundColor: AppColors.background,
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
                  backgroundColor: AppColors.cardBackground,
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
                  color: AppColors.cardBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text("Sign In",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            )),
                        const SizedBox(height: 20),

                        // Email
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: GoogleFonts.poppins(
                                color: AppColors.textSecondary),
                            prefixIcon: Icon(Icons.email_outlined,
                                color: AppColors.iconDefault),
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
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(
                                color: AppColors.textSecondary),
                            prefixIcon: Icon(Icons.lock_outline,
                                color: AppColors.iconDefault),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.account_circle),
                          ),
                          items: _roles
                              .map((r) => DropdownMenuItem(
                                    value: r,
                                    child: Text(r.name),
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
                              backgroundColor: AppColors.buttonBlue,
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

                              // ✅ Navigate to correct dashboard
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DashboardScreen(
                                    userName: email,
                                    role: _selectedRole!.name,
                                    menuItems:
                                        _getMenuItemsForRole(_selectedRole!),
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
                                    Map<String, String>?
                                        extraFields, // 👈 added here
                                  }) {
                                    // You could save the user in DB here too
                                    Navigator.pop(
                                        context); // Go back after successful registration

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Registered as ${role.name} ($email) "
                                          "${extraFields != null ? " Extra: $extraFields" : ""}",
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
                            style: GoogleFonts.poppins(
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
