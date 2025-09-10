class ChatMessage {
  final String senderId;
  final String type;
  final String content;

  ChatMessage({
    required this.senderId,
    required this.type,
    required this.content,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderId: json['sender_id']?.toString() ?? "unknown",
      type: json['message_type']?.toString() ?? "text",
      content: json['message']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"type": "message", "message_type": type, "message": content};
  }
}
