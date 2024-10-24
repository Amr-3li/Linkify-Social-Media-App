import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/bost_reaction_bar.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_header.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(name: "amr"),
          SizedBox(height: 10),
          Divider(),
          ReactionContainerBar()
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
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          const SizedBox(height: 10),
          image == ""
              ? const SizedBox()
              : ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: width - 100, maxHeight: 400),
                  child: CachedNetworkImage(
                    imageUrl: image,
                  )),
        ],
      ),
    );
  }
}
