import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PostReactionBarItem(
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Comments",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              });
        },
        icon: Icons.comment,
        text: "Comment");
  }
}
