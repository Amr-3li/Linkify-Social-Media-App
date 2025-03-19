// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  final String id;
  final String comment;
  final String user;
  final String userId;
  final String postId;
  CommentModel({
    required this.id,
    required this.comment,
    required this.user,
    required this.userId,
    required this.postId,
  });

  CommentModel copyWith({
    String? id,
    String? comment,
    String? user,
    String? userId,
    String? postId,
  }) {
    return CommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      user: user ?? this.user,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'user': user,
      'userId': userId,
      'postId': postId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as String,
      comment: map['comment'] as String,
      user: map['user'] as String,
      userId: map['userId'] as String,
      postId: map['postId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommentModel(id: $id, comment: $comment, user: $user, userId: $userId, postId: $postId)';
  }

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.comment == comment &&
        other.user == user &&
        other.userId == userId &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        comment.hashCode ^
        user.hashCode ^
        userId.hashCode ^
        postId.hashCode;
  }
}
