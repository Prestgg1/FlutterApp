import 'dart:convert';
import 'package:safatapp/components/chat_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  late WebSocketChannel channel;

  void connect(
    String chatId,
    String userId,
    Function(ChatMessage) onMessage,
    Function(bool) onConnectionChange,
    Function(bool) onUserPresence,
  ) {
    channel = WebSocketChannel.connect(
      Uri.parse("wss://bimonet.com/api/chat/ws/$chatId/$userId"),
    );

    channel.stream.listen(
      (message) {
        final data = jsonDecode(message);

        // presence idarəsi
        if (data["type"] == "presence_snapshot" ||
            data["type"] == "presence" ||
            data["status"] != null) {
          onUserPresence(data["status"] == "online");
          return;
        }

        // mesaj idarəsi
        if (data["type"] == "message") {
          final msg = ChatMessage.fromJson(data);
          onMessage(msg);
        }
      },
      onDone: () => onConnectionChange(false),
      onError: (err) => onConnectionChange(false),
    );

    onConnectionChange(true);
  }

  void sendMessage(ChatMessage msg) {
    channel.sink.add(jsonEncode(msg.toJson()));
  }

  void disconnect() {
    channel.sink.close();
  }
}
