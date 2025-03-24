import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comments_widget.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';

class ReactionContainerBar extends StatefulWidget {
  const ReactionContainerBar({
    super.key,
    required this.postTime,
  });
  final String postTime;
  @override
  State<ReactionContainerBar> createState() => _ReactionContainerStateBar();
}

class _ReactionContainerStateBar extends State<ReactionContainerBar> {
  bool isLove = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          PostReactionBarItem(
            onTap: () {
              setState(() {
                isLove = !isLove;
              });
            },
            icon: Icons.favorite,
            text: "Like",
            isLove: isLove,
          ),
          CommenstWidget(postTime: widget.postTime),
          PostReactionBarItem(onTap: () {}, icon: Icons.share, text: "Share"),
        ]));
  }
}
