import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  String _selectedSection = "Inbox";

  // ✅ Controllers for compose form
  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: isWide
          ? Row(
              children: [
                _buildSidebar(), // ✅ Sidebar for wide screens
                Expanded(child: _buildContentArea()),
              ],
            )
          : Column(
              children: [
                Expanded(child: _buildContentArea()),
                _buildBottomNav(), // ✅ Bottom nav for mobile
              ],
            ),
    );
  }

  // ✅ Sidebar
  Widget _buildSidebar() {
    return Container(
      width: 220,
      color: AppColors.cardBackground,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBlue,
              foregroundColor: AppColors.buttonTextLight,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => setState(() => _selectedSection = "Compose"),
            icon: const Icon(Icons.edit),
            label: const Text("Compose"),
          ),
          const SizedBox(height: 32),
          _menuItem("Inbox", Icons.inbox),
          _menuItem("Outbox", Icons.upload),
          _menuItem("Trash", Icons.delete),
        ],
      ),
    );
  }

  // ✅ Bottom nav (for small screens)

  Widget _buildBottomNav() {
    final sections = ["Inbox", "Outbox", "Trash", "Compose"]; // ✅ added Compose
    final icons = [Icons.inbox, Icons.upload, Icons.delete, Icons.edit];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // ✅ ensures 4 items fit
      backgroundColor: AppColors.cardBackground,
      selectedItemColor: AppColors.selectedMenu,
      unselectedItemColor: AppColors.iconDefault,
      currentIndex: sections.indexOf(_selectedSection),
      onTap: (i) {
        setState(() {
          _selectedSection = sections[i];
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(icons[0]), label: "Inbox"),
        BottomNavigationBarItem(icon: Icon(icons[1]), label: "Outbox"),
        BottomNavigationBarItem(icon: Icon(icons[2]), label: "Trash"),
        BottomNavigationBarItem(
            icon: Icon(icons[3]), label: "Compose"), // ✅ New
      ],
    );
  }

  // ✅ Content wrapper
  Widget _buildContentArea() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _selectedSection,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Divider(color: AppColors.divider),
              const SizedBox(height: 8),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Menu Item
  Widget _menuItem(String title, IconData icon) {
    final isSelected = _selectedSection == title;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.buttonTextLight : AppColors.iconDefault,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.buttonTextLight : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? AppColors.selectedMenu : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => setState(() => _selectedSection = title),
    );
  }

  // ✅ Content switch
  Widget _buildContent() {
    switch (_selectedSection) {
      case "Compose":
        return _composeForm();
      case "Inbox":
        return _messageList("Inbox");
      case "Outbox":
        return _messageList("Outbox");
      case "Trash":
        return _messageList("Trash");
      default:
        return const Center(
          child: Text(
            "Select an option.",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        );
    }
  }

  // ✅ Compose Form
  Widget _composeForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _toController,
            decoration: const InputDecoration(
              labelText: "To",
              border: OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.isEmpty ? "Enter recipient" : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: "Subject",
              border: OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.isEmpty ? "Enter subject" : null,
          ),
          const SizedBox(height: 12),
          // ✅ Wrap the message box in Expanded only when inside Expanded parent
          Flexible(
            child: TextFormField(
              controller: _messageController,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (v) => v == null || v.isEmpty ? "Enter message" : null,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                foregroundColor: AppColors.buttonTextLight,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Message Sent ✅")),
                  );
                  setState(() {
                    _selectedSection = "Outbox"; // move to Outbox
                  });
                  _toController.clear();
                  _subjectController.clear();
                  _messageController.clear();
                }
              },
              icon: const Icon(Icons.send),
              label: const Text("Send"),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Fake message list
  Widget _messageList(String type) {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (_, __) => Divider(color: AppColors.divider),
      itemBuilder: (context, i) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.accentOrange,
            child: Text(type[0], style: const TextStyle(color: Colors.white)),
          ),
          title: Text("Message $i in $type",
              style: const TextStyle(color: AppColors.textPrimary)),
          subtitle: const Text("Preview of the message...",
              style: TextStyle(color: AppColors.textSecondary)),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 14, color: AppColors.iconDefault),
          onTap: () {},
        );
      },
    );
  }
}
