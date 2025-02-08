class MessageModel {
  final String fromId;
  final String toId;
  final bool lastMessage;
  final String time;
  final String? imageUrl;
  final String? msg;
  final int unreadCount;

  MessageModel(
      {required this.fromId,
      required this.toId,
      required this.lastMessage,
      required this.time,
      this.imageUrl,
      this.msg,
      required this.unreadCount});
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msg: json['message'] ?? "",
      fromId: json['fromId'],
      lastMessage: json['LastMessage'],
      time: json['time'],
      imageUrl: json['imageUrl'] ?? "",
      unreadCount: json['unreadCount'],
      toId: json['toId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'LastMessage': lastMessage,
      'time': time,
      'imageUrl': imageUrl ?? "",
      'message': msg ?? "",
      'unreadCount': unreadCount,
    };
  }
}
