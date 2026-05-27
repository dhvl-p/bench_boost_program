/// Enum representing the status of a chat message.
enum MessageStatus { sending, sent, delivered }

/// Model representing a single chat message.
class ChatMessageModel {
  final String id;
  final String text;
  final String sender;
  final DateTime timestamp;
  MessageStatus status;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.status = MessageStatus.sending,
  });

  /// Whether this message was sent by the current user.
  bool get isMe => sender == 'me';

  /// Creates a [ChatMessageModel] from a JSON map.
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      text: json['text'] as String,
      sender: json['sender'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => MessageStatus.sent,
      ),
    );
  }

  /// Converts this model to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
      'timestamp': timestamp.toIso8601String(),
      'status': status.name,
    };
  }
}
