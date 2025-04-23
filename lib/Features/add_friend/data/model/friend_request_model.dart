class FriendRequestModel {
  final String fromId;
  final String toId;
  final String status; // pending, accepted, rejected
  final String timestamp;

  FriendRequestModel({
    required this.fromId,
    required this.toId,
    required this.status,
    required this.timestamp,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      fromId: json['fromId'] ?? '',
      toId: json['toId'] ?? '',
      status: json['status'] ?? 'pending', // pending, accepted, requested
      timestamp: json['timestamp'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'status': status,
      'timestamp': timestamp,
    };
  }
}
