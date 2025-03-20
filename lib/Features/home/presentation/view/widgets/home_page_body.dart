import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/home_page_appbar.dart';
import 'package:linkify/Features/home/presentation/view/widgets/posts_list.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const HomePageAppBar(),
      ],
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        strokeWidth: 2,
        displacement: 10,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async =>
            BlocProvider.of<GetPostsCubit>(context).getAllPosts(),
        child: const PostsList(),
      ),
    );
  }
}
