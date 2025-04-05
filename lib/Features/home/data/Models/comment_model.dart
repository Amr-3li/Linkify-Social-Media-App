class CommentModel {
  final String comment;
  final String userName;
  final String userImage;
  final String userId;
  final String time;

  CommentModel({
    required this.comment,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'userName': userName,
      'userImage': userImage,
      'userId': userId,
      'time': time,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment']?.toString() ?? '',
      userName: map['userName']?.toString() ?? '',
      userImage: map['userImage']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      time: map['time']?.toString() ?? '',
    );
  }
}
