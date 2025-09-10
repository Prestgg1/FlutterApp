import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:safatapp/components/chat_message.dart';
import 'package:safatapp/components/message_bubble.dart';
import 'package:safatapp/services/chat/chatsession.dart';
import 'package:safatapp/services/chat/file_upload_service.dart';
import '../../services/auth/authbloc.dart';
import '../../services/auth/authstate.dart';
import '../../services/chat/chat_message_service.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  const ChatScreen({super.key, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatSession chatSession = ChatSession();
  final ChatService chatService = ChatService();

  late backend.UserBase user;
  List<ChatMessage> messages = [];
  bool loading = true;
  bool connected = false;
  bool online = false;

  @override
  void initState() {
    super.initState();
    _initChat();
  }

  void _initChat() {
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated && authState.user != null) {
      user = authState.user!;
      chatService.connect(
        widget.id,
        user.id.toString(),
        (msg) => setState(() {
          messages.add(msg);
          loading = false;
        }),
        (conn) => setState(() => connected = conn),
        (status) => setState(() => online = status),
      );
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final msg = ChatMessage(
      senderId: user.id.toString(),
      type: "text",
      content: text.trim(),
    );
    chatService.sendMessage(msg);
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 60,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    chatService.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF248C76),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal,
              child: Image(
                image: NetworkImage("${chatSession.otherUserImage}"),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: Colors.white);
                },
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatSession.otherUserName ?? "Chat",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  online ? "Online" : "Offline",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
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
                      final isMe = msg.senderId == user.id.toString();
                      return MessageBubble(message: msg, isMe: isMe);
                    },
                  ),
          ),
          if (connected && chatSession.isActive)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file,
                        color: Color(0xFF248C76),
                      ),
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles();
                        if (result != null && result.files.isNotEmpty) {
                          final file = result.files.first;
                          if (file.path != null) {
                            final uploadedUrl = await FileUploadService()
                                .uploadFile(file.path!);
                            if (uploadedUrl != null) {
                              print("✅ Uploaded image URL: $uploadedUrl");

                              // Mesaj olarak gönder
                              final msg = ChatMessage(
                                senderId: user.id.toString(),
                                type: "image",
                                content: uploadedUrl,
                              );
                              chatService.sendMessage(msg);
                            }
                          }
                        }
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
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
                      onPressed: () => _sendMessage(_messageController.text),
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
