import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_posts/get_user_posts_cubit.dart';

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
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Error"),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Not Posts Exist"),
            ),
          );
        }
      },
    );
  }
}
