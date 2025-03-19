// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:linkify/Features/posts/data/model/comment_model.dart';

class PostModel {
  final String imageUrl;
  final String description;
  final String time;
  final String userId;
  final int likes;
  final List<CommentModel> comments;
  final int shares;
  PostModel({
    required this.imageUrl,
    required this.description,
    required this.time,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'description': description,
      'time': time,
      'userId': userId,
      'likes': likes,
      'comments': comments.map((x) => x.toMap()).toList(),
      'shares': shares,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      time: map['time'] as String,
      userId: map['userId'] as String,
      likes: map['likes'] as int,
      comments: List<CommentModel>.from(
        (map['comments'] as List<int>).map<CommentModel>(
          (x) => CommentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shares: map['shares'] as int,
    );
  }
}
