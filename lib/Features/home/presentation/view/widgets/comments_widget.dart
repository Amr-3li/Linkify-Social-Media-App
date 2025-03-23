import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';

class CommenstWidget extends StatelessWidget {
  const CommenstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PostReactionBarItem(
      onTap: () {
        GoRouter.of(context).push('/commentsPage');
      },
      icon: Icons.comment,
      text: "Comment",
    );
  }
}
