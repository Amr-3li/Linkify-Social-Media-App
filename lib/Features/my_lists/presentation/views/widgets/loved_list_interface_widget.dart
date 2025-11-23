import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/my_lists/presentation/views/pages/love_list_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/my_lists/presentation/cubit/get_loved_list/get_loved_list_cubit.dart';
import 'package:linkify/Features/my_lists/presentation/views/widgets/list_title.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';

class LovedListInterfaceWidget extends StatelessWidget {
  const LovedListInterfaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLovedListCubit, GetLovedListState>(
      builder: (context, state) {
        if (state is GetLovedListLoaded && state.postsList.isNotEmpty) {
          return Column(
            children: [
              ListTitle(
                icon: Icons.favorite,
                title: Constants.lovedList.tr(),
                onTap: () => GoRouter.of(context).push(LoveListPage.routeName),
              ),
              PostContainer(post: state.postsList.first),
            ],
          );
        }
        if (state is GetLovedListLoading) {
          return const Center(
            child: Skeletonizer(child: LoadingPost()),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
