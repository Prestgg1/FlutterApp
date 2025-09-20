import 'package:flutter/material.dart';
import 'package:safatapp/components/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final isImage = message.type == "image";

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF248C76) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: isImage
            ? Image.network(
                message.content,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              )
            : Text(
                message.content,
                style: TextStyle(color: isMe ? Colors.white : Colors.black87),
              ),
      ),
    );
  }
}
