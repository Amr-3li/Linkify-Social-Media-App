class NotificationModel {
  String? id;
  String? title;
  String? message;
  String? time;
  String? type;
  String? fromId;
  String? toId;
  bool? isRead;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.time,
    this.type,
    this.fromId,
    this.toId,
    this.isRead,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    time = json['time'];
    type = json['type'];
    fromId = json['fromId'];
    toId = json['toId'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['time'] = time;
    data['type'] = type;
    data['fromId'] = fromId;
    data['toId'] = toId;
    data['isRead'] = isRead;
    return data;
  }
}
