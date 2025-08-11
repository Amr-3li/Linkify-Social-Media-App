import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/images.dart';

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
                backgroundImage: commentModel.userImage == ""
                    ? const AssetImage(MyImages.imagesUserImage)
                    : CachedNetworkImageProvider(commentModel.userImage),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentModel.userName,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
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
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            maxLines: 17,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
