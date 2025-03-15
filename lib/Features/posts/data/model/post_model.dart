// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:linkify/Features/posts/data/model/comment_model.dart';

class PostModel {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String date;
  final String userId;
  final int likes;
  final List<CommentModel> comments;
  final int shares;
  PostModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.date,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.shares,
  });

  PostModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? description,
    String? date,
    String? userId,
    int? likes,
    List<CommentModel>? comments,
    int? shares,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'date': date,
      'userId': userId,
      'likes': likes,
      'comments': comments.map((x) => x.toMap()).toList(),
      'shares': shares,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
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

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, imageUrl: $imageUrl, description: $description, date: $date, userId: $userId, likes: $likes, comments: $comments, shares: $shares)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.date == date &&
        other.userId == userId &&
        other.likes == likes &&
        listEquals(other.comments, comments) &&
        other.shares == shares;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        likes.hashCode ^
        comments.hashCode ^
        shares.hashCode;
  }
}
