import 'package:flutter/material.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingPost extends StatelessWidget {
  const LoadingPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: PostContainer(
          post: PostModel(
        description: Constants.skeltonizerTextmedium3,
        time: Constants.skeltonizertime,
        userId: Constants.skeltonizerTextSmall1,
        userName: Constants.skeltonizerTextSmall2,
        userImage: Constants.defaultUserImage,
        likes: [],
        comments: [],
        imageUrl: "",
        shares: 1,
      )),
    );
  }
}
