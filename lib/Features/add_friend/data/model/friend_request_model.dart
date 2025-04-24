class FriendRequestModel {
  final String fromId;
  final String toId;
  final String status; // pending, accepted, rejected

  FriendRequestModel({
    required this.fromId,
    required this.toId,
    required this.status,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      fromId: json['fromId'] ?? '',
      toId: json['toId'] ?? '',
      status: json['status'] ?? 'pending', // pending, accepted, requested
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'status': status,
    };
  }
}
