import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
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
      () async {
        final cubit = context.read<GetLovedListCubit>();
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent &&
            cubit.hasMore) {
          print('load more loved posts......');
          await cubit.getLikedPostsList();
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
          child: BlocConsumer<GetLovedListCubit, GetLovedListState>(
            listener: (context, state) {
              if (state is GetLovedListLoaded) {
                postsList.addAll(state.postsList);
              }
              if (state is GetLovedListRefreshed) {
                postsList.clear();
                postsList.addAll(state.postsList);
              }
            },
            builder: (context, state) {
              if (postsList.isNotEmpty) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: postsList.length,
                  itemBuilder: (context, index) {
                    return PostContainer(post: postsList[index]);
                  },
                );
              }

              if (state is GetLovedListLoading) {
                return Center(child: Skeletonizer(child: LoadingPost()));
              }

              return SizedBox.shrink();
            },
          )),
    );
  }
}
