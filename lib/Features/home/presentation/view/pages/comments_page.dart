import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comments_page_body.dart';
import 'package:linkify/core/constants/colors.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            "Comments",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          ),
          backgroundColor: MyColors.appBarColor),
      body: const CommentsPageBody(),
    );
  }
}
