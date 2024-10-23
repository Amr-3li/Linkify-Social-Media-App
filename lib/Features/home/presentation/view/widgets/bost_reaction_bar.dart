import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';

class ReactionContainerBar extends StatefulWidget {
  const ReactionContainerBar({
    super.key,
  });

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
        child: Row(children: [
          const SizedBox(width: 10),
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
          const Spacer(),
          PostReactionBarItem(
              onTap: () {}, icon: Icons.comment, text: "Comment"),
          const Spacer(),
          PostReactionBarItem(onTap: () {}, icon: Icons.share, text: "Share"),
          const SizedBox(width: 10),
        ]));
  }
}
