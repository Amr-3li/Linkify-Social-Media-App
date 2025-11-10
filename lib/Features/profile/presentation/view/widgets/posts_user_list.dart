import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_posts/get_user_posts_cubit.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:lottie/lottie.dart';

class PostsUserList extends StatelessWidget {
  const PostsUserList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsCubit, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoaded && state.posts.isNotEmpty) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              return PostContainer(post: state.posts[index]);
            },
            itemCount: state.posts.length,
          );
        } else if (state is GetUserPostsloading) {
          return const SliverToBoxAdapter(
            child: LoadingPost(),
          );
        } else if (state is GetUserPostsFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(Constants.error.tr()),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              child: Lottie.asset(
                MyAnimation.animationsNotExist,
              ),
            ),
          );
        }
      },
    );
  }
}
