import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/my_lists/presentation/cubit/get_saved_list/get_saved_list_cubit.dart';
import 'package:linkify/Features/my_lists/presentation/views/pages/save_list_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:linkify/Features/home/presentation/view/widgets/losding_post.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/Features/my_lists/presentation/views/widgets/list_title.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';

class SavedListInterfaceWidget extends StatelessWidget {
  const SavedListInterfaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSavedListCubit, GetSavedListState>(
      builder: (context, state) {
        if (state is GetSavedListLoaded && state.postsList.isNotEmpty) {
          return Column(
            children: [
              ListTitle(
                icon: Icons.bookmark,
                title: Constants.savedList.tr(),
                onTap: () => GoRouter.of(context).push(SaveListPage.routeName),
              ),
              PostContainer(post: state.postsList.first),
            ],
          );
        }
        if (state is GetSavedListLoading) {
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
