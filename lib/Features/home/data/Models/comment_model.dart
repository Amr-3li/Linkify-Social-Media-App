class CommentModel {
  final String comment;
  final String userName;
  final String userImage;
  final String userId;
  final String postId;
  final String time;
  CommentModel({
    required this.comment,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.postId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'userName': userName,
      'userImage': userImage,
      'time': time,
      'userId': userId,
      'postId': postId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
        comment: map['comment'] as String,
        userName: map['userName'] as String,
        userImage: map['userImage'] as String,
        userId: map['userId'] as String,
        postId: map['postId'] as String,
        time: map['time'] as String);
  }
}
