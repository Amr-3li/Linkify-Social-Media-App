import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/profile_body.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                floating: true,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 10),
                  title: const Text("User name"),
                  centerTitle: true,
                  background: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ],
        body: const ProfileBody());
  }
}
