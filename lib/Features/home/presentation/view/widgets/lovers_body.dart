import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_lovers/get_post_lovers_cubit.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/images.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoversBody extends StatelessWidget {
  const LoversBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostLoversCubit, GetPostLoversState>(
      builder: (context, state) {
        if (state is GetPostLoversloading) {
          return Center(
              child: Skeletonizer(
                  child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  ListTile(
                    onTap: null,
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(MyImages.imagesUserImage),
                    ),
                    title: Text("User Name"),
                  ),
                  Divider(
                      color: MyColors.fromMessageBorder,
                      indent: 15,
                      endIndent: 15,
                      height: 5,
                      thickness: 0.6),
                ],
              );
            },
          )));
        } else if (state is GetPostLoversSuccess && state.lovers.isNotEmpty) {
          return ListView.builder(
            itemCount: state.lovers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: null,
                    leading: CircleAvatar(
                      backgroundImage: state.lovers[index].image == ""
                          ? const AssetImage(MyImages.imagesUserImage)
                          : CachedNetworkImageProvider(
                              state.lovers[index].image),
                    ),
                    title: Text(state.lovers[index].name),
                  ),
                  const Divider(
                      color: MyColors.fromMessageBorder,
                      indent: 15,
                      endIndent: 15,
                      height: 5,
                      thickness: 0.6),
                ],
              );
            },
          );
        } else {
          return Center(
            child: Lottie.asset(MyAnimation.animationsNotExist),
          );
        }
      },
    );
  }
}
