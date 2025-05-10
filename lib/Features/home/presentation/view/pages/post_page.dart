import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post/get_post_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/core/constants/colors.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetPostCubit, GetPostState>(
          builder: (context, state) {
            if (state is GetPostLoading) {
              return const Center(child: LoadingPost());
            } else if (state is GetPostSuccess) {
              return PostContainer(post: state.post);
            } else {
              return const Center(child: LoadingPost());
            }
          },
        ),
      ),
    );
  }
}
