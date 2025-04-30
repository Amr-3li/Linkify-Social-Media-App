import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:lottie/lottie.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostsCubit, GetPostsState>(
      builder: (context, state) {
        if (state is GetPostsloading) {
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return const LoadingPost();
            },
          );
        } else if (state is GetPostsSuccess) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return PostContainer(post: state.posts[index]);
            },
          );
        } else if (state is GetPostsFailure) {
          print(state.error);
          return Center(
            child: LottieBuilder.asset(
              MyAnimation.animationsNotExist,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
