import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/view/widgets/bost_reaction_bar.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_header.dart';
import 'package:linkify/core/constants/colors.dart';

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
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: MyColors.shadowColor,
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          const SizedBox(height: 10),
          PostContent(
            image: post.imageUrl,
            text: post.description,
          ),
          const Divider(),
          ReactionContainerBar(
            post: post,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 15),
              InkWell(
                onTap: () {
                  GoRouter.of(context).push('/lovesPage/${post.time}');
                },
                child: Text("${post.likes.length}  love",
                    style: const TextStyle(color: Colors.grey)),
              ),
              const Spacer(),
              Text("${post.comments.length}  comments",
                  style: const TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          const SizedBox(height: 10),
          image == ""
              ? const SizedBox()
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width - 20,
                    maxHeight: 400,
                    minHeight: 200,
                    minWidth: 200,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                  )),
        ],
      ),
    );
  }
}
