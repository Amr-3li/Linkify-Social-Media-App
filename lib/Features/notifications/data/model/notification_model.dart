class NotificationModel {
  final String fromUserName;
  final String fromUserId;
  final String? fromUserImage;
  final String discription;
  final String time;
  final String type;
  final int numOfTypeReations;
  final bool isreading;
  final String postId;

  NotificationModel(
      {required this.fromUserId,
      required this.fromUserName,
      this.fromUserImage,
      required this.discription,
      required this.time,
      required this.type,
      required this.numOfTypeReations,
      required this.isreading,
      required this.postId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      fromUserId: json['fromUserId'],
      fromUserName: json['fromUserName'],
      fromUserImage: json['fromUserImage'] ?? "",
      discription: json['discription'],
      time: json['time'],
      type: json['type'],
      numOfTypeReations: json['numOfTypeReations'],
      isreading: json['isreading'],
      postId: json['postId'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromUserId'] = fromUserId;
    data['fromUserName'] = fromUserName;
    data['fromUserImage'] = fromUserImage;
    data['discription'] = discription;
    data['time'] = time;
    data['type'] = type;
    data['numOfTypeReations'] = numOfTypeReations;
    data['isreading'] = isreading;
    data['postId'] = postId;
    return data;
  }
}
