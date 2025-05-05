import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    // أول تحميل
    context.read<GetPostsCubit>().getMyTimelinePosts();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore) {
        setState(() => isLoadingMore = true);

        await context.read<GetPostsCubit>().getMyTimelinePosts();

        setState(() => isLoadingMore = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostsCubit, GetPostsState>(
      builder: (context, state) {
        if (state is GetPostsloading && !(state is GetPostsSuccess)) {
          // تحميل أول مرة
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => const LoadingPost(),
          );
        } else if (state is GetPostsSuccess) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.posts.length + 1, // +1 عشان الـ loader
            itemBuilder: (context, index) {
              if (index < state.posts.length) {
                return PostContainer(post: state.posts[index]);
              } else {
                // آخر عنصر: loader
                return isLoadingMore
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }
            },
          );
        } else if (state is GetPostsFailure) {
          return Center(child: Text("Error: ${state.error}"));
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
