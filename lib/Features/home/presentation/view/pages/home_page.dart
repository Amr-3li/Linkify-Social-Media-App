import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/home_page_appbar.dart';
import 'package:linkify/Features/home/presentation/view/widgets/posts_list.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<GetPostsCubit>(context)..loadInitialPosts(),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const HomePageAppBar(),
        ],
        body: RefreshIndicator(
          color: MyColors.iconActiveColor,
          backgroundColor: Colors.white,
          strokeWidth: 2,
          displacement: 10,
          elevation: 5,
          notificationPredicate: (notification) => true,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async =>
              await BlocProvider.of<GetPostsCubit>(context).refreshPosts(),
          child: BlocProvider(
            create: (context) => UserCubit(gitItInstanse<UserDataRepo>()),
            child: BlocProvider(
              create: (context) =>
                  GetUserDataCubit(gitItInstanse<UserDataRepo>()),
              child: const PostsList(),
            ),
          ),
        ),
      ),
    );
  }
}
