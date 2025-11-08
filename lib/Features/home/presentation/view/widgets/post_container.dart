import 'package:flutter/material.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_content.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_header.dart';
import 'package:linkify/core/exports/app_router.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
    required this.post,
  });
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 20,
                offset: const Offset(0, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider.value(
            value: GetUserDataCubit(gitItInstanse<UserDataRepo>()),
            child: PostHeader(post: post),
          ),
          const SizedBox(height: 10),
          PostContent(image: post.imageUrl, text: post.description),
          const Divider(),
          PostReactionBar(
            post: post,
          ),
        ],
      ),
    );
  }
}
