import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';
import 'package:linkify/core/constants/constants.dart';

class CommenstWidget extends StatelessWidget {
  const CommenstWidget({
    super.key,
    required this.postTime,
  });
  final String postTime;
  @override
  Widget build(BuildContext context) {
    return PostReactionBarItem(
      onTap: () {
        GoRouter.of(context).push('/commentsPage/$postTime');
      },
      icon: Icons.comment,
      text: Constants.comments,
      openList: () {
        GoRouter.of(context).push('/commentsPage/$postTime');
      },
    );
  }
}
