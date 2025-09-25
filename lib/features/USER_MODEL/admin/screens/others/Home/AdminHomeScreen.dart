// import 'package:flutter/material.dart';
// import 'package:odr_court_app/features/USER_MODEL/Common_Screens/app_color.dart';
// import 'package:odr_court_app/features/USER_MODEL/admin/screens/Submitted_Documents/SubmittedDocumentScreen.dart';
//
// class AdminHomeScreen extends StatefulWidget {
//   const AdminHomeScreen({super.key});
//
//   @override
//   State<AdminHomeScreen> createState() => _AdminHomeScreenState();
// }
//
// class _AdminHomeScreenState extends State<AdminHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isWide = size.width > 800;
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- Header ---
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       "Welcome, Admin",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       "Dashboard Overview",
//                       style: TextStyle(color: AppColors.textSecondary),
//                     ),
//                   ],
//                 ),
//                 const CircleAvatar(
//                   radius: 28,
//                   backgroundColor: AppColors.primary,
//                   child: Icon(
//                     Icons.admin_panel_settings,
//                     size: 32,
//                     color: AppColors.buttonTextLight,
//                   ),
//                 )
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // --- Case Summary (Responsive Grid) ---
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: isWide ? 4 : 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: isWide ? 1.5 : 1.2,
//               ),
//               itemCount: 4,
//               itemBuilder: (context, index) {
//                 switch (index) {
//                   case 0:
//                     return _buildSummaryCard(
//                         "Total Cases", "120", Icons.folder, AppColors.primary);
//                   case 1:
//                     return _buildSummaryCard("Active Cases", "45",
//                         Icons.playlist_add_check, Colors.green);
//                   case 2:
//                     return _buildSummaryCard("Pending Cases", "15",
//                         Icons.pending_actions, AppColors.accentOrange);
//                   case 3:
//                     return _buildSummaryCard(
//                         "Closed Cases", "60", Icons.check_circle, Colors.red);
//                   default:
//                     return const SizedBox.shrink();
//                 }
//               },
//             ),
//
//             const SizedBox(height: 24),
//
//             // --- Quick Actions ---
//             const Text(
//               "Quick Actions",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _buildActionChip(
//                   Icons.check,
//                   "Approve Documents",
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const SubmittedDocumentsScreen()),
//                     );
//                   },
//                 ),
//                 // _buildActionChip(Icons.event, "Schedule Hearing"),
//                 // _buildActionChip(Icons.upload_file, "Upload Notice"),
//                 // _buildActionChip(Icons.payment, "Manage Payments"),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // --- Recent Activity ---
//             const Text(
//               "Recent Activity",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Column(
//               children: [
//                 _buildActivityTile("New complaint filed", "17 Sept 2025"),
//                 _buildActivityTile("Arbitrator assigned", "16 Sept 2025"),
//                 _buildActivityTile("Document approved", "15 Sept 2025"),
//                 _buildActivityTile("Payment received", "14 Sept 2025"),
//               ],
//             ),
//
//             const SizedBox(height: 24),
//
//             // --- Upcoming Events ---
//             const Text(
//               "Upcoming Events_&_Schedule",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Column(
//               children: [
//                 _buildEventCard(
//                     "20 Sept 2025", "Hearing: Case C-2025-012", "Scheduled"),
//                 _buildEventCard(
//                     "22 Sept 2025", "Submission Deadline", "Pending"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- Widgets ---
//   Widget _buildSummaryCard(
//       String title, String count, IconData icon, Color color) {
//     return Card(
//       color: AppColors.cardBackground,
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 28),
//             Text(
//               count,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionChip(IconData icon, String label,
//       {required VoidCallback onPressed}) {
//     return ActionChip(
//       avatar: Icon(icon, color: AppColors.buttonTextLight, size: 20),
//       label:
//           Text(label, style: const TextStyle(color: AppColors.buttonTextLight)),
//       backgroundColor: AppColors.primary,
//       onPressed: onPressed,
//     );
//   }
//
//   Widget _buildActivityTile(String text, String date) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         leading: const Icon(Icons.history, color: AppColors.iconDefault),
//         title: Text(text, style: const TextStyle(color: AppColors.textPrimary)),
//         subtitle:
//             Text(date, style: const TextStyle(color: AppColors.textSecondary)),
//       ),
//     );
//   }
//
//   Widget _buildEventCard(String date, String event, String status) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         leading: const Icon(Icons.event, color: AppColors.primary),
//         title:
//             Text(event, style: const TextStyle(color: AppColors.textPrimary)),
//         subtitle: Text("Date: $date",
//             style: const TextStyle(color: AppColors.textSecondary)),
//         trailing: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: AppColors.accentOrange.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             status,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: AppColors.accentOrange,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
