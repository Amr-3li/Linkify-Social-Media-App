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

class PostHeader extends StatefulWidget {
  const PostHeader({super.key, required this.post});
  final PostModel post;

  @override
  State<PostHeader> createState() => _PostHeaderState();
}

class _PostHeaderState extends State<PostHeader> {
  @override
  void initState() {
    super.initState();
    context.read<GetUserDataCubit>().getUserData(widget.post.userId);
  }

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
            PostUserData(
                name: user.name,
                time: widget.post.time,
                userId: widget.post.userId),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push('${PostPage.routeName}/${widget.post.time}');
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
        } else if (state is GetUserDataLoading) {
          return Skeletonizer(
              child: ListTile(
            leading: CircleAvatar(
              radius: 20,
            ),
            title: Text(Constants.skeltonizerTextSmall2),
            subtitle: Text(Constants.skeltonizerTextSmall1),
          ));
        } else {
          return Row(children: [
            CircleAvatar(
              backgroundImage: widget.post.userImage == ""
                  ? const AssetImage(MyImages.imagesUserImage)
                  : CachedNetworkImageProvider(widget.post.userImage),
            ),
            const SizedBox(width: 10),
            PostUserData(
                name: widget.post.userName,
                time: widget.post.time,
                userId: widget.post.userId),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push('${PostPage.routeName}/${widget.post.time}');
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
        }
      },
    );
  }

  PopupMenuItem<dynamic> editItem(BuildContext context) {
    return PopupMenuItem(
        onTap: () {
          Dialogs.editPostDialog(context, widget.post.description,
              widget.post.userId, widget.post.time);
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
          Dialogs.deletePostDialog(
              context, widget.post.userId, widget.post.time);
        },
        child: const Text(Constants.delete,
            style: TextStyle(
                color: Colors.red, fontSize: 17, fontWeight: FontWeight.w600)));
  }
}
