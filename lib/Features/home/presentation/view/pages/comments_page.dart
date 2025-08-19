import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comments_page_body.dart';
import 'package:linkify/core/constants/constants.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, required this.postTime});
  final String postTime;
  static const String routeName = '/commentsPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.comments,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: CommentsPageBody(
        postTime: postTime,
      ),
    );
  }
}
