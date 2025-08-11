import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/custom_appbar_profile.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/posts_user_list.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/profile_information.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/user_relation_status_bar.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, state) {
          if (state is GetUserDataLoaded) {
            return CustomScrollView(
              slivers: [
                BlocProvider(
                  create: (context) => UpdateUserCubit(
                      gitItInstanse<ImageRepo>(),
                      gitItInstanse<UserDataRepo>()),
                  child: CustomAppbarProfile(
                      name: state.user.name, image: state.user.image!),
                ),
                SliverToBoxAdapter(
                  child: UserRelationStatusBar(userId: state.user.id!),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            blurRadius: 10,
                            offset: const Offset(0, 10))
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ProfileInformation(user: state.user),
                  ),
                ),
                const PostsUserList(),
              ],
            );
          } else if (state is GetUserDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(Constants.error),
            );
          }
        },
      ),
    );
  }
}
