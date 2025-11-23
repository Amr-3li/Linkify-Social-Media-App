import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/cubit/save_unsave_post/save_unsave_post_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/my_lists/presentation/cubit/get_saved_list/get_saved_list_cubit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SaveListPage extends StatefulWidget {
  const SaveListPage({super.key});
  static const String routeName = '/SaveListPage';

  @override
  State<SaveListPage> createState() => _SaveListPageState();
}

class _SaveListPageState extends State<SaveListPage> {
  List<PostModel> postsList = [];
  late ScrollController _scrollController;
  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        final cubit = context.read<GetSavedListCubit>();
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            cubit.hasMore) {
          cubit.getSavedPostsList();
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
          await context.read<GetSavedListCubit>().refresh();
        },
        child: BlocBuilder<GetSavedListCubit, GetSavedListState>(
            builder: (context, state) {
          if (state is GetSavedListLoaded && state.postsList.isNotEmpty) {
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
          if (state is GetSavedListLoading) {
            return Center(
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
