// import 'package:flutter/material.dart';
// import 'package:odr_court_app/features/admin/models/app_state.dart';
// import 'package:odr_court_app/widgets/app_color.dart';
// import 'package:provider/provider.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final appState = Provider.of<AppState>(context);
//
//     return Scaffold(
//       body: Container(
//         // ✅ Subtle gradient background for a modern feel
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.background, Color(0xFFE3F2FD)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final isWide = constraints.maxWidth > 600;
//             final formWidth = isWide ? 450.0 : double.infinity;
//
//             return Center(
//               child: SingleChildScrollView(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(maxWidth: formWidth),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // ---------- Brand Header ----------
//                       Card(
//                         elevation: 8,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24),
//                         ),
//                         color: AppColors.cardBackground,
//                         margin: const EdgeInsets.only(bottom: 32),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 32),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.gavel,
//                                 size: 90,
//                                 color: AppColors.accentOrange,
//                               ),
//                               const SizedBox(height: 16),
//                               Text(
//                                 'UC ADR',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineMedium
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.textPrimary,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Resolve disputes online quickly & securely',
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium
//                                     ?.copyWith(color: AppColors.textSecondary),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // ---------- Login Form Card ----------
//                       Card(
//                         color: AppColors.cardBackground,
//                         elevation: 8,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(24),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               const Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w700,
//                                   color: AppColors.textPrimary,
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//
//                               // Email
//                               TextField(
//                                 controller: _emailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Email',
//                                   prefixIcon: Icon(Icons.email),
//                                   border: OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//
//                               // Password with visibility toggle
//                               TextField(
//                                 controller: _passwordController,
//                                 obscureText: _obscurePassword,
//                                 decoration: InputDecoration(
//                                   labelText: 'Password',
//                                   prefixIcon: const Icon(Icons.lock),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _obscurePassword
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                     ),
//                                     onPressed: () => setState(() =>
//                                         _obscurePassword = !_obscurePassword),
//                                   ),
//                                   border: const OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//
//                               // Login Button
//                               SizedBox(
//                                 height: 48,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.primary,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(14),
//                                     ),
//                                     elevation: 4,
//                                   ),
//                                   onPressed: () =>
//                                       Navigator.pushReplacementNamed(
//                                           context, '/dashboard'),
//                                   child: const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.buttonTextLight,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//
//                               // Create Account Link
//                               Center(
//                                 child: TextButton(
//                                   onPressed: () =>
//                                       Navigator.pushNamed(context, '/register'),
//                                   child: const Text(
//                                     'Create an account',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.primary,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//
//                       // ---------- Quick Login Roles ----------
//                       Column(
//                         children: [
//                           Text(
//                             'Quick-login as role (demo)',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(
//                                   color: AppColors.textSecondary,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                           const SizedBox(height: 16),
//                           Wrap(
//                             spacing: 12,
//                             runSpacing: 12,
//                             alignment: WrapAlignment.center,
//                             children: Role.values.map((r) {
//                               return OutlinedButton(
//                                 style: OutlinedButton.styleFrom(
//                                   foregroundColor: AppColors.textPrimary,
//                                   side: const BorderSide(
//                                     color: AppColors.primary,
//                                     width: 1.5,
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 12),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   appState.setRole(r);
//                                   Navigator.pushReplacementNamed(
//                                       context, '/dashboard');
//                                 },
//                                 child: Text(
//                                   r.toString().split('.').last,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
