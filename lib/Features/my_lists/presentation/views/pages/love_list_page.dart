import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/cubit/save_unsave_post/save_unsave_post_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/my_lists/presentation/cubit/get_loved_list/get_loved_list_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoveListPage extends StatefulWidget {
  const LoveListPage({super.key});
  static const String routeName = '/LoveListPage';

  @override
  State<LoveListPage> createState() => _LoveListPageState();
}

class _LoveListPageState extends State<LoveListPage> {
  List<PostModel> postsList = [];
  late ScrollController _scrollController;
  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        final cubit = context.read<GetLovedListCubit>();
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            cubit.hasMore) {
          cubit.getLikedPostsList();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Constants.lovedList.tr()),
      body: RefreshIndicator(
        onRefresh: () async {
          postsList.clear();
          await context.read<GetLovedListCubit>().refresh();
        },
        child: BlocBuilder<GetLovedListCubit, GetLovedListState>(
            builder: (context, state) {
          if (state is GetLovedListLoaded && state.postsList.isNotEmpty) {
            postsList.addAll(state.postsList);
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (_) =>
                        AddRemoveLoveCubit(gitItInstanse<PostControlRepo>())),
                BlocProvider(
                    create: (_) =>
                        SaveUnsavePostCubit(gitItInstanse<PostControlRepo>())),
              ],
              child: ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (context, index) {
                  return PostContainer(post: postsList[index]);
                },
              ),
            );
          }
          if (state is GetLovedListLoading) {
            return const Center(
              child: Skeletonizer(child: LoadingPost()),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
