import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comment_container.dart';
import 'package:linkify/core/constants/colors.dart';

class CommentsPageBody extends StatefulWidget {
  const CommentsPageBody({
    super.key,
  });

  @override
  State<CommentsPageBody> createState() => _CommentsPageBodyState();
}

class _CommentsPageBodyState extends State<CommentsPageBody> {
  String comment = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const CommentContainer();
            },
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.iconNavColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write a comment",
                    ),
                    maxLines: 3,
                    minLines: 1,
                    onChanged: (value) {
                      setState(() {
                        comment = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                comment != ""
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send,
                            color: MyColors.iconActiveColor))
                    : const SizedBox.shrink(),
              ],
            )),
      ],
    );
  }
}
