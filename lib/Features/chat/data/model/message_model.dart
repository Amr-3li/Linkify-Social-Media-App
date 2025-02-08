class MessageModel {
  final String fromId;
  final String toId;
  final bool lastMessage;
  final bool imageExist;
  final String time;
  final String? imageUrl;
  final String? msg;
  final int unreadCount;

  MessageModel(
      {required this.imageExist,
      required this.fromId,
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
      imageExist: json['imageExist'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'LastMessage': lastMessage,
      'imageExist': imageExist,
      'time': time,
      'imageUrl': imageUrl ?? "",
      'message': msg ?? "",
      'unreadCount': unreadCount,
    };
  }
}
