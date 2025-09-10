import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/components/chat_message.dart';
import 'package:safatapp/services/api.dart';
import 'package:safatapp/components/message_bubble.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final api = ApiService().api;

  List<backend.AIChatMessages> messages = [];
  bool loading = true;
  bool sending = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final res = await api.getChatsApi().getAiChatsApiChatsAiGet();
      setState(() {
        messages = res.data?.toList() ?? [];
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      sending = true;
      messages.add(
        backend.AIChatMessages(
          (b) => b
            ..id = -1
            ..message = text
            ..senderId = 99,
        ),
      ); // user msg
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final res = await api.getChatsApi().sendAiMessageApiChatsAiPost(
        question: text,
      );
      setState(() {
        messages.add(
          backend.AIChatMessages(
            (b) => b
              ..id = -2
              ..message = res.data?.answer ?? "Cavab alınmadı"
              ..senderId = 0,
          ),
        );
      });
      _scrollToBottom();
    } finally {
      setState(() => sending = false);
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Səfa AI",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF248C76),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId != 0;
                      return MessageBubble(
                        message: ChatMessage(
                          senderId: msg.senderId.toString(),
                          type: "text",
                          content: msg.message,
                        ),
                        isMe: isMe,
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Mesaj yazın...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sending ? null : _sendMessage,
                    icon: const Icon(Icons.send, color: Color(0xFF248C76)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
