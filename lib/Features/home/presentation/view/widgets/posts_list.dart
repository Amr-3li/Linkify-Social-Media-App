import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/core/constants/constants.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    final cubit = context.read<GetPostsCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        cubit.hasMore) {
      await cubit.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostsCubit, GetPostsState>(
      builder: (context, state) {
        if (state is GetPostsloading) {
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (_, __) => const LoadingPost(),
          );
        } else if (state is GetPostsSuccess) {
          final posts = state.posts;
          return ListView.builder(
            controller: _scrollController,
            itemCount: posts.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return PostContainer(post: posts[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        } else if (state is GetPostsFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      context.read<GetPostsCubit>().loadInitialPosts(),
                  child: const Text(Constants.tryAgain),
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
