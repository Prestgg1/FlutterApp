import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';
import 'package:safatapp/services/chat/chatsession.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  List<backend.ChatResponse> chats = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  Future<void> fetchChats() async {
    try {
      final api = ApiService().api;
      final response = await api.getChatsApi().getCustomerChatsApiChatsGet();
      setState(() {
        chats = (response.data?.toList() ?? []);
        loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      print('Xəta baş verdi: $e');
    }
  }

  String formatLastMessageTime(dynamic lastMessageDate) {
    if (lastMessageDate == null) return "";
    try {
      final dateStr = lastMessageDate.toString();
      final dt = DateTime.tryParse(dateStr);
      if (dt == null) return "";
      return formatTime(dt);
    } catch (e) {
      return "";
    }
  }

  String formatTime(DateTime? dt) {
    if (dt == null) return "";
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(dt.year, dt.month, dt.day);

    if (dateOnly == today) {
      return DateFormat.Hm().format(dt);
    } else if (dateOnly == yesterday) {
      return "Dünən";
    } else {
      return DateFormat("dd.MM.yyyy").format(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mesajlar",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _chatTile(
                  context,
                  chatId: 0, // xüsusi id
                  otherUserId: 0, // sistem üçün
                  doctorName: "SəfaTapp AI",
                  image:
                      "https://img.icons8.com/fluency/96/robot-2.png", // robot ikonu
                  lastMessage: "Salam 👋 Mən sizin köməkçinizəm.",
                  time: "",
                  active: true,
                ),
                const Divider(),
                for (var chat in chats)
                  _chatTile(
                    context,
                    chatId: chat.chatId!,
                    doctorName: chat.otherUserName,
                    otherUserId: chat.otherUserId!,
                    image: chat.otherUserImage,
                    lastMessage:
                        chat.lastMessage
                            ?.toString() ??
                        "",
                    time: formatLastMessageTime(
                      chat.lastMessageDate
                              ?.toString() ??
                          "",
                    ),
                    unread: chat.unreadCount,
                    active: !chat.isClosed,
                  ),
              ],
            ),
    );
  }

  Widget _chatTile(
    BuildContext context, {
    required int chatId,
    required int otherUserId,
    required String doctorName,
    required String image,
    required String lastMessage,
    required String time,
    required bool active,
    int unread = 0,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Image.network(
          image,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, color: Colors.white);
          },
        ),
      ),
      title: Text(
        doctorName,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          if (unread > 0)
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: Text(
                unread.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          else if (!active)
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Closed",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
        ],
      ),
      onTap: () {
        if (active) {
          /// ✅ Singleton-a yazırıq
          ChatSession().setChat(
            chatId: chatId,
            otherUserId: otherUserId,
            isActive: active,
            otherUserName: doctorName,
            otherUserImage: image,
          );
          if (otherUserId == 0 && chatId == 0) {
            context.push('/ai-chat');
          } else {
            context.push('/chat/$chatId');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Bu həkimlə chat bitib. Yeni rezervasiya yaradın."),
            ),
          );
        }
      },
    );
  }
}
