import 'package:flutter/material.dart';
import 'package:odr_court_app/features/auth/Reusable_Widget/app_color.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, String>> messages = [
    {"sender": "Admin", "text": "Welcome to the case communication channel."},
    {
      "sender": "Claimant",
      "text": "Thank you. I wanted to confirm my next hearing date."
    },
    {
      "sender": "Admin",
      "text": "Your next hearing is scheduled for 28th Sep 2025 at 11:00 AM."
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages
          .add({"sender": "Claimant", "text": _messageController.text.trim()});
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    bool isClaimant = message["sender"] == "Claimant";
    return Align(
      alignment: isClaimant ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isClaimant
              ? AppColors.primary
                  .withOpacity(0.15) // claimant message background
              : AppColors.cardBackground, // admin message background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment:
              isClaimant ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message["sender"]!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isClaimant ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message["text"]!,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          ),

          // Input Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
              border: Border(
                top: BorderSide(color: AppColors.divider),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
