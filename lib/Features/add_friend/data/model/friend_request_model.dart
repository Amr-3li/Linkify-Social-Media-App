class FriendRequestModel {
  final String senderId;
  final String receiverId;
  final String status; // pending, accepted, rejected

  FriendRequestModel({
    required this.senderId,
    required this.receiverId,
    required this.status,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    return FriendRequestModel(
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      status: json['status'] ?? 'pending', // pending, accepted, requested
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'status': status,
    };
  }
}
