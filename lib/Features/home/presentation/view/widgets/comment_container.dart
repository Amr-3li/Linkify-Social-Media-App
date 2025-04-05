import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class CommentContainer extends StatelessWidget {
  const CommentContainer({
    super.key,
    required this.commentModel,
  });
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(
        DateTime.fromMillisecondsSinceEpoch(int.parse(commentModel.time))
            .toString());
    final DateFormat formatter = DateFormat('dd-MMM-yyyy', 'en_US');
    String formattedDate = formatter.format(dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {},
          leading: SizedBox(
            width: 40,
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundImage: NetworkImage(Constants.defaultUserImage),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentModel.userName,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                formattedDate,
                style: const TextStyle(color: MyColors.time, fontSize: 12),
              ),
            ],
          ),
          subtitle: Text(
            commentModel.comment,
            style: const TextStyle(color: Colors.black),
            maxLines: 17,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
