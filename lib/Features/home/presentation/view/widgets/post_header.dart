import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_user_data.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';

class PostHeader extends StatelessWidget {
  const PostHeader(
      {super.key, required this.name, required this.time, required this.image});
  final String name;
  final String image;
  final String time;
  @override
  Widget build(BuildContext context) {
    final GlobalKey iconButtonKey = GlobalKey();
    return Row(children: [
      ClipOval(
          child: CachedNetworkImage(
        imageUrl: image != "" ? image : Constants.defaultUserImage,
        width: 45,
      )),
      const SizedBox(width: 10),
      PostUserData(name: name, time: time),
      const Spacer(),
      IconButton(
          key: iconButtonKey,
          onPressed: () {
            final RenderBox renderBox =
                iconButtonKey.currentContext!.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);
            final Size size = renderBox.size;
            showMenu(
              color: MyColors.iconNavColor,
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
                PopupMenuItem(
                    onTap: () {},
                    child: const Text("Delete",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w600))),
                const PopupMenuItem(
                  height: 1,
                  child: Divider(
                    thickness: 1,
                    color: MyColors.fontColor,
                  ),
                ),
                PopupMenuItem(
                    onTap: () {},
                    child: const Text("edit",
                        style: TextStyle(
                            color: MyColors.iconActiveColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600))),
              ],
            );
          },
          icon: const Icon(Icons.more_vert, size: 30)),
    ]);
  }
}
