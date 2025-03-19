import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/home_page_appbar.dart';
import 'package:linkify/Features/home/presentation/view/widgets/posts_list.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const HomePageAppBar(),
            ],
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    gitItInstanse<GetPostsCubit>()..getAllPosts())
          ],
          child: const PostsList(),
        ));
  }
}
