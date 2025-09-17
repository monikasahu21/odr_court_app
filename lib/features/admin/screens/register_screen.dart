// import 'package:flutter/material.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _mobileController = TextEditingController();
//
//   String _country = 'India';
//   bool _obscurePassword = true;
//   bool _agreeTerms = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top link
//               Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Go to Marketplace',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Title
//               const Text(
//                 'Create an Account',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // Disputant chip
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Text(
//                   'Disputant',
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               const SizedBox(height: 28),
//
//               // First & Last Name
//               Row(
//                 children: [
//                   Expanded(
//                     child: _field(
//                       controller: _firstNameController,
//                       label: 'First Name *',
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _field(
//                       controller: _lastNameController,
//                       label: 'Last Name *',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               _field(
//                 controller: _emailController,
//                 label: 'Email',
//                 keyboard: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 20),
//
//               // Password
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscurePassword,
//                 decoration: InputDecoration(
//                   labelText: 'Password *',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                     ),
//                     onPressed: () =>
//                         setState(() => _obscurePassword = !_obscurePassword),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Country Dropdown
//               InputDecorator(
//                 decoration: InputDecoration(
//                   labelText: 'Country *',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: _country,
//                     isExpanded: true,
//                     items: const [
//                       DropdownMenuItem(value: 'India', child: Text('India')),
//                       DropdownMenuItem(value: 'USA', child: Text('USA')),
//                       DropdownMenuItem(value: 'UK', child: Text('UK')),
//                     ],
//                     onChanged: (v) => setState(() => _country = v ?? 'India'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Mobile with +91
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 14),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(4),
//                       color: Colors.grey.shade100,
//                     ),
//                     child: const Text('+91'),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: _field(
//                       controller: _mobileController,
//                       label: 'Mobile Number',
//                       keyboard: TextInputType.phone,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Terms
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Checkbox(
//                     value: _agreeTerms,
//                     onChanged: (v) => setState(() => _agreeTerms = v ?? false),
//                   ),
//                   Expanded(
//                     child: Text.rich(
//                       TextSpan(
//                         style: const TextStyle(fontSize: 13),
//                         text:
//                             'I hereby affirm that I am voluntarily signing up on this platform and confirm that all the information I have provided is accurate and truthful to the best of my knowledge. Additionally, I acknowledge that I have read, understood, and agree to be bound by the platform\'s Privacy Policy and Terms of Service. ',
//                         children: [
//                           TextSpan(
//                             text: 'Terms and Conditions',
//                             style: TextStyle(
//                               color: Colors.blue.shade700,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 28),
//
//               // Register button
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                   ),
//                   onPressed: _agreeTerms
//                       ? () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Registered!')),
//                           );
//                         }
//                       : null,
//                   child: const Text(
//                     'Register',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Login link
//               Center(
//                 child: TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Already have an account? ',
//                         style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Text(
//                         ' Login',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _field({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboard,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//     );
//   }
// }
