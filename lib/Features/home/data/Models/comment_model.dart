// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  final String comment;
  final String user;
  final String userId;
  final String postId;
  final String time;
  CommentModel({
    required this.comment,
    required this.user,
    required this.userId,
    required this.postId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'user': user,
      'userId': userId,
      'postId': postId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
        comment: map['comment'] as String,
        user: map['user'] as String,
        userId: map['userId'] as String,
        postId: map['postId'] as String,
        time: map['time'] as String);
  }
}
