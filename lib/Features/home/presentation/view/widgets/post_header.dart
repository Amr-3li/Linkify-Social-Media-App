import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/view/pages/post_page.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_user_data.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/widgets/dialogs.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    final GlobalKey iconButtonKey = GlobalKey();
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
      builder: (context, state) {
        if (state is GetUserDataLoaded) {
          final user = state.user;
          return Row(children: [
            CircleAvatar(
              backgroundImage: user.image == ""
                  ? const AssetImage(MyImages.imagesUserImage)
                  : CachedNetworkImageProvider(user.image!),
            ),
            const SizedBox(width: 10),
            PostUserData(name: user.name, time: post.time, userId: post.userId),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push('${PostPage.routeName}/${post.time}');
                    },
                    child: Container(
                      height: 40,
                    ))),
            IconButton(
                key: iconButtonKey,
                onPressed: () {
                  final RenderBox renderBox = iconButtonKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  final Size size = renderBox.size;
                  showMenu(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    shadowColor: const Color.fromARGB(255, 180, 180, 180),
                    position: RelativeRect.fromLTRB(
                      offset.dx, // الـ x بتاع الـ IconButton
                      offset.dy + size.height, // الـ y تحت الـ IconButton
                      offset.dx + size.width, // نهاية الـ x
                      offset.dy + size.height + 100,
                    ),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    context: context,
                    items: [
                      deleteItem(context),
                      const PopupMenuItem(
                        height: 1,
                        child: Divider(
                          thickness: 1,
                          color: MyColors.fontColor,
                        ),
                      ),
                      editItem(context),
                    ],
                  );
                },
                icon: const Icon(Icons.more_vert, size: 30)),
          ]);
        } else {
          return Skeletonizer(
              child: ListTile(
            leading: CircleAvatar(
              radius: 20,
            ),
            title: Text(Constants.skeltonizerTextSmall2),
            subtitle: Text(Constants.skeltonizerTextSmall1),
          ));
        }
      },
    );
  }

  PopupMenuItem<dynamic> editItem(BuildContext context) {
    return PopupMenuItem(
        onTap: () {
          Dialogs.editPostDialog(
              context, post.description, post.userId, post.time);
        },
        child: const Text(Constants.edit,
            style: TextStyle(
                color: MyColors.iconActiveColor,
                fontSize: 17,
                fontWeight: FontWeight.w600)));
  }

  PopupMenuItem<dynamic> deleteItem(BuildContext context) {
    return PopupMenuItem(
        onTap: () {
          Dialogs.deletePostDialog(context, post.userId, post.time);
        },
        child: const Text(Constants.delete,
            style: TextStyle(
                color: Colors.red, fontSize: 17, fontWeight: FontWeight.w600)));
  }
}
