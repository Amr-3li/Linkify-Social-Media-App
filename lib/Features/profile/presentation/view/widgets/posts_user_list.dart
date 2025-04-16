import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_posts/get_user_posts_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostsUserList extends StatelessWidget {
  const PostsUserList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsCubit, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoaded && state.posts.isNotEmpty) {
          return ListView.builder(
            primary: false,
            itemCount: state.posts.length,
            itemBuilder: (context, index) =>
                PostContainer(post: state.posts[index]),
          );
        } else if (state is GetUserPostsloading) {
          return SingleChildScrollView(
            child: Skeletonizer(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  width: double.infinity,
                  height: 500,
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  width: double.infinity,
                  height: 300,
                )
              ],
            )),
          );
        } else if (state is GetUserPostsFailure) {
          return const Center(
            child: Text("Error"),
          );
        } else {
          return const Center(
            child: Text("Not Posts Exist"),
          );
        }
      },
    );
  }
}
