import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_header.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostHeader(name: "amr"),
          const SizedBox(height: 10),
          const Text(
              "lorem ipsum dolor sit amet\nlorem ipsum dolor sit amet \nlorem ipsum dolor sit amet",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              )),
          const SizedBox(height: 10),
          const Divider(),
          ReactionContainer()
        ],
      ),
    );
  }
}

class ReactionContainer extends StatelessWidget {
  const ReactionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
              width: 0.25,
            )),
        child: const Row(children: [
          SizedBox(width: 10),
          Icon(
            Icons.favorite_border,
            color: Colors.black,
          ),
          SizedBox(width: 5),
          Text(
            "Like",
            style: TextStyle(color: Colors.black),
          ),
          Spacer(),
          Icon(
            Icons.message,
            color: Colors.black,
          ),
          SizedBox(width: 5),
          Text(
            "Comment",
            style: TextStyle(color: Colors.black),
          ),
          Spacer(),
          Icon(
            Icons.share,
            color: Colors.black,
          ),
          SizedBox(width: 5),
          Text(
            "Share",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 10),
        ]));
  }
}
