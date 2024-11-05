class ChatItemModel {
  final String name;
  final String lastMessage;
  final String time;
  final String? imageUrl;
  final int unreadCount;

  ChatItemModel(
      {required this.name,
      required this.lastMessage,
      required this.time,
      this.imageUrl,
      required this.unreadCount});
  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    return ChatItemModel(
      name: json['name'],
      lastMessage: json['LastMessage'],
      time: json['time'],
      imageUrl: json['imageUrl'] ?? "",
      unreadCount: json['unreadCount'],
    );
  }
}
