class ChatSession {
  static final ChatSession _instance = ChatSession._internal();

  factory ChatSession() {
    return _instance;
  }

  ChatSession._internal();

  int? chatId;
  int? otherUserId;
  String? otherUserName;
  String? otherUserImage;
  bool isActive = true;

  void setChat({
    required int chatId,
    required int otherUserId,
    required String otherUserName,
    required String otherUserImage,
    required bool isActive,
  }) {
    this.chatId = chatId;
    this.otherUserId = otherUserId;
    this.otherUserName = otherUserName;
    this.otherUserImage = otherUserImage;
    isActive = true;
  }

  void clear() {
    chatId = null;
    otherUserId = null;
    otherUserName = null;
    otherUserImage = null;
    isActive = true;
  }
}
