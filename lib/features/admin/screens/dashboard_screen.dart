// import 'package:flutter/material.dart';
// import 'package:odr_court_app/features/admin/widget/ExperienceForm.dart';
// import 'package:odr_court_app/features/admin/widget/SideMenuDeshboard.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selected = 0;
//
//   final _items = const [
//     MenuItemData('Home', Icons.home),
//     MenuItemData('General', Icons.person),
//     MenuItemData('Contact Information', Icons.contact_mail),
//     MenuItemData('Addresses', Icons.location_on),
//     MenuItemData('Experience', Icons.business),
//     MenuItemData('Qualifications', Icons.school),
//     MenuItemData('Area of Practice', Icons.star_border),
//     MenuItemData('Area of Expertise', Icons.star_half),
//     MenuItemData('Licenses & Registrations', Icons.account_balance),
//     MenuItemData('Client Testimonials', Icons.comment),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (_, c) {
//         final wide = c.maxWidth >= 700;
//         return Scaffold(
//           backgroundColor: Colors.grey.shade100,
//           appBar: wide
//               ? null
//               : AppBar(
//                   backgroundColor: Colors.deepOrange,
//                   title: Text(_items[_selected].title),
//                 ),
//           drawer: wide
//               ? null
//               : Drawer(
//                   child: SideMenu(
//                     selected: _selected,
//                     items: _items,
//                     onItemTap: (i) => setState(() => _selected = i),
//                     isDrawer: true,
//                   ),
//                 ),
//           body: Row(
//             children: [
//               if (wide)
//                 SideMenu(
//                   selected: _selected,
//                   items: _items,
//                   onItemTap: (i) => setState(() => _selected = i),
//                 ),
//               Expanded(child: _content()),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   /// right content
//   Widget _content() {
//     final title = _items[_selected].title;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         const SizedBox(height: 40),
//         const CircleAvatar(
//           radius: 40,
//           backgroundColor: Colors.grey,
//           child: Icon(Icons.person, size: 50, color: Colors.white70),
//         ),
//         const SizedBox(height: 8),
//         const Text('Srittam Das',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 24),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 4,
//                       offset: Offset(0, 2)),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: title == 'Experience'
//                     ? const ExperienceForm()
//                     : _defaultSection(title),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _defaultSection(String t) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(t == 'Home' ? 'About' : t,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           const Divider(),
//           const SizedBox(height: 8),
//           const Text('-', style: TextStyle(fontSize: 14)),
//         ],
//       );
// }
